# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

# Set properties
properties() { '
kernel.string=UndergroundKernel for Xiaomi Redmi Note 4(X)
do.devicecheck=1
do.modules=0
do.systemless=0
do.cleanup=1
do.cleanuponabort=1
device.name1=mido
supported.versions=8.1.0 - 11
supported.patchlevels=
'; }

# Set shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;
patch_vbmeta_flag=auto;

# Set attributes
attributes() {
set_perm_recursive 0 0 755 755 $patch/*
set_perm_recursive 0 0 750 750 $ramdisk/init*;
}

# Import functions/variables and setup patching
. tools/ak3-core.sh && attributes;

# Import UndergroundKernel Anykernel helper
. tools/ak3-helper.sh

# Check kernel version
check_kernel_version;

# Vendor changes
inject_init_scripts;

# Dump boot
dump_boot;

# Ramdisk changes
modify_ramdisk;

# Write boot
write_boot;
