#!/system/bin/sh
# Helper script by Zile995

# Write function
write() { 
    echo -n $2 > $1;
}

# Restore file
restore_file() { 
    test -f $1~ && cp -fp $1~ $1; rm -f $1~; 
}

# Remount vendor partition as read/write 
remount_rw_vendor() { 
    mount -o rw,remount -t auto /vendor >/dev/null 
}

# Remount vendor partition as read only 
remount_ro_vendor() { 
    mount -o ro,remount -t auto /vendor >/dev/null 
}

# Remove UndergroundKernel scripts
remove_vendor_scripts() { 
    rm -rf /vendor/etc/init/hw/underground
}

# Get current spectrum profile
get_spectrum_profile() { 
    return "$(getprop persist.spectrum.profile)"
}

# Get boot completed property
is_boot_completed() {
    return "$(getprop sys.boot_completed)"
}

# Set defauult spectrum property 
check_or_set_spectrum() {
    android=$(getprop ro.build.version.sdk)
    value="persist.spectrum.profile"

    if [[ $android -ge 28 ]]; then
        if (! (grep -q $value /data/property/persistent_properties)); then
            setprop persist.spectrum.profile 0
        fi
    else
        if [ ! -f /data/property/persist.spectrum.profile ]; then
            setprop persist.spectrum.profile 0
        fi
    fi
}
