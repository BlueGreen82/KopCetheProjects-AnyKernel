#!/system/bin/sh
# Helper script by Zile995

# Import helper functions
. patch/underground/init.helper.sh;

check_kernel_version() {
    ui_print " ";
    ui_print "Checking the kernel version...";
    if [ -f /vendor/etc/init/hw/init.msm.usb.configfs.rc ]; then
        ui_print " ";
        ui_print "Your ROM is using a 4.9 kernel. Underground kernel can't be flashed!";
        exit 1;
    fi;
}

backup_init() {
    ui_print "Backing up init file...";
    restore_file /vendor/etc/init/hw/init.target.rc;
    backup_file /vendor/etc/init/hw/init.target.rc;
}

copy_init_scripts() {
    get_android_version;
    android_version=$?;
    if [[ "$android_version" -gt "9" ]]; then
        # Mount vendor partition
        ui_print "Mounting vendor partition...";
        remount_rw_vendor;

        # Copy init scripts
        ui_print "Copying init scripts...";
        cp -rf /tmp/anykernel/patch/underground /vendor/etc/init/hw/;
		
        # Remove uneeded ramdisk files
        rm /tmp/anykernel/ramdisk/*;
  
        # Make a backup of init.target.rc
        backup_init;

        # Add init configuration to init.target.rc
        append_file /vendor/etc/init/hw/init.target.rc "Underground" init.target.rc;
    fi;
}

modify_ramdisk() {
    get_android_version;
    android_version=$?;
    if [[ "$android_version" -lt "10" ]]; then
        ui_print " ";
        ui_print "Modifying ramdisk...";
        cp -rf /tmp/anykernel/patch/underground/* /tmp/anykernel/ramdisk/
        insert_line init.rc "import /init.underground.rc" after "import /init.\${ro.zygote}.rc" "import /init.underground.rc";
    fi;
}
