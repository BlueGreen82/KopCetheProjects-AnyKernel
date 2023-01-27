#!/system/bin/sh
# Post-boot script by Zile995

# Import helper functions
FULLPATH=$(readlink -f $0)
INCFOLDER=${FULLPATH%/*}
. $INCFOLDER/init.helper.sh;

# Remove scripts with unknown kernel
on_remove_unknown_kernel() {
    kernel=`cat /proc/sys/kernel/osrelease`;
    kernelstr=${kernel:9:11};

    if [[ "$kernelstr" != "Underground" ]]; then
        remount_rw_vendor;
        remove_vendor_scripts;
        restore_file /vendor/etc/init/hw/init.target.rc;
        remount_ro_vendor;
    fi;
}

# Configure zRAM
configure_zram() {
    MemTotalStr=`cat /proc/meminfo | grep MemTotal`;
    MemTotal=${MemTotalStr:16:8};

    # For >2GB Non-Go devices, size = 50% of RAM size
    diskSizeUnit=M;
    let RamSizeGB="( $MemTotal / 1048576 ) + 1";
    let zRamSizeMB="( $RamSizeGB * 1024 ) / 2";

    # Set disksize permission
    chmod 0644 /sys/block/zram0/disksize;
    
    # Setup zRAM options
    swapoff /dev/block/zram0;
    echo 1 > /sys/block/zram0/reset;
    echo 0 > /proc/sys/vm/page-cluster;
    echo 8 > /sys/block/zram0/max_comp_streams;
    echo "lz4" > /sys/block/zram0/comp_algorithm;

    # Set zRAM disksize
    if [ -f /sys/block/zram0/disksize ]; then
        echo "$zRamSizeMB""$diskSizeUnit" > /sys/block/zram0/disksize;
        mkswap /dev/block/zram0;
        swapon /dev/block/zram0 -p 32758;
    fi;
}

# Configure LMK Minfree values
configure_lmk() {
    write /sys/module/lowmemorykiller/parameters/minfree "18432,23040,27648,32256,36864,46080";
}

# Set CFG I/O Scheduler and read ahead to 128kB for internal and 512kB for external storage
configure_io_scheduler() {
    for block in mmcblk0 mmcblk1 dm-0 dm-1 sda; do
        write /sys/block/$block/queue/scheduler cfq;
        write /sys/block/$block/queue/iostats 0;
        write /sys/block/$block/queue/nr_requests 128;
        write /sys/block/$block/queue/add_random 0;
    done;
    
    # Set read ahead
    write /sys/block/mmcblk0/queue/read_ahead_kb 128;
    write /sys/block/mmcblk1/queue/read_ahead_kb 512;
	
    # Disable slice_idle
    for block in mmcblk0 mmcblk1 dm-0 dm-1 sda; do
        write /sys/block/$block/queue/iosched/slice_idle 0;
    done;
}

# Reduce yellow flashlight
reduce_yellow_flashlight() {
    chmod 0644 /sys/devices/soc/qpnp-flash-led-25/leds/led:torch_1/max_brightness;
    write /sys/devices/soc/qpnp-flash-led-25/leds/led:torch_1/max_brightness 20;
}

on_remove_unknown_kernel;
check_or_set_spectrum;
configure_zram;
configure_lmk;
configure_io_scheduler;
reduce_yellow_flashlight;
