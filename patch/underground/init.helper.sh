#!/system/bin/sh
# Helper script by osm0sis and Zile995 @ xda-developers

# Write function
write() { 
    echo -n $2 > $1;
}

# Restore file
restore_file() { 
    test -f $1~ && cp -fp $1~ $1; rm -f $1~; 
}

# Get file property
file_getprop() {
  grep "^$2=" "$1" | tail -n1 | cut -d= -f2-;
}

# Remount vendor partition as read/write 
remount_rw_vendor() { 
    mount -o rw,remount -t auto /vendor >/dev/null;
}

# Remount vendor partition as read only 
remount_ro_vendor() { 
    mount -o ro,remount -t auto /vendor >/dev/null;
}

# Remove UndergroundKernel scripts
remove_ug_scripts() { 
    rm -rf /vendor/etc/init/hw/underground;
}

# Backup and remove ROM init files
backup_and_remove_rom_init() {
    ui_print "Backing up init file...";
    backup_file /vendor/etc/init/hw/init.gpuboost.rc;
    backup_file /vendor/etc/init/hw/init.cpuboost.rc;
    backup_file /vendor/etc/init/hw/init.spectrum.rc;
    backup_file /vendor/etc/init/hw/init.parallax.rc;
    rm /vendor/etc/init/hw/init.gpuboost.rc;
    rm /vendor/etc/init/hw/init.cpuboost.rc;
    rm /vendor/etc/init/hw/init.spectrum.rc;
    rm /vendor/etc/init/hw/init.parallax.rc;
    restore_file /vendor/etc/init/hw/init.target.rc;
    backup_file /vendor/etc/init/hw/init.target.rc;
}

# Restore ROM init files
restore_rom_init() {
    restore_file /vendor/etc/init/hw/init.gpuboost.rc;
    restore_file /vendor/etc/init/hw/init.cpuboost.rc;
    restore_file /vendor/etc/init/hw/init.spectrum.rc;
    restore_file /vendor/etc/init/hw/init.parallax.rc;
    restore_file /vendor/etc/init/hw/init.target.rc;
}

# Get current spectrum profile
get_spectrum_profile() { 
    return "$(getprop persist.spectrum.profile)";
}

# Get boot completed property
is_boot_completed() {
    return "$(getprop sys.boot_completed)";
}

# Get android version
get_android_version() {
	android_version="$(file_getprop /system/build.prop ro.build.version.release)";
    return "$android_version";
}
