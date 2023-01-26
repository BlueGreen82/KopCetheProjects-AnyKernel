#!/system/bin/sh
# SPECTRUM & FRANCO KERNEL MANAGERS
# Profile initialization by Zile995

# Import helper functions
FULLPATH=$(readlink -f $0)
INCFOLDER=${FULLPATH%/*}
. $INCFOLDER/init.helper.sh

get_spectrum_profile;
spectrum_profile=$?

is_boot_completed;
boot_completed=$?

set_default_thermal_zones() {
    write /sys/kernel/msm_thermal/enabled 0
    write /sys/kernel/msm_thermal/zone0 "2016000 42 41"
    write /sys/kernel/msm_thermal/zone1 "1804800 43 42"
    write /sys/kernel/msm_thermal/zone2 "1689600 44 41"
    write /sys/kernel/msm_thermal/zone3 "1401600 50 48"
    write /sys/kernel/msm_thermal/zone4 "1036800 54 52"
    write /sys/kernel/msm_thermal/zone5 "0 0 0"
    write /sys/kernel/msm_thermal/zone6 "0 0 0"
    write /sys/kernel/msm_thermal/zone7 "0 0 0"
    write /sys/kernel/msm_thermal/zone8 "0 0 0"
    write /sys/kernel/msm_thermal/sampling_ms 3000
    write /sys/kernel/msm_thermal/enabled 1
}

# Set profile
if [[ $boot_completed -eq 1 ]]; then

    chmod 0644 /sys/module/workqueue/parameters/power_efficient
    chmod 0644 /sys/class/kgsl/kgsl-3d0/max_gpuclk
    chmod 0644 /sys/class/kgsl/kgsl-3d0/devfreq/max_freq
    chmod 0664 /sys/class/kgsl/kgsl-3d0/devfreq/governor
    chmod 0644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    chmod 0644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
    chmod 0644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
    chmod 0644 /sys/devices/soc/soc:qcom,cpubw/devfreq/soc:qcom,cpubw/governor
    chmod 0644 /sys/devices/soc/soc:qcom,cpubw/devfreq/soc:qcom,cpubw/max_freq
    chmod 0644 /sys/devices/soc/soc:qcom,cpubw/devfreq/soc:qcom,cpubw/min_freq
    chmod 0644 /sys/devices/soc/soc:qcom,mincpubw/devfreq/soc:qcom,mincpubw/governor
    chmod 0644 /sys/devices/soc/soc:qcom,mincpubw/devfreq/soc:qcom,mincpubw/max_freq
    chmod 0644 /sys/devices/soc/soc:qcom,mincpubw/devfreq/soc:qcom,mincpubw/min_freq

    echo "conservative" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    echo "msm-adreno-tz" > /sys/class/kgsl/kgsl-3d0/devfreq/governor

    if [[ $spectrum_profile -eq 0 ]]; then
    	write /sys/module/workqueue/parameters/power_efficient Y
    	write /sys/devices/system/cpu/cpufreq/conservative/up_threshold 85
    	write /sys/devices/system/cpu/cpufreq/conservative/down_threshold 30
    	write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 2016000
    	write /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq 652800
    	write /sys/module/cpu_boost/parameters/input_boost_freq 1036800
    	write /sys/module/cpu_boost/parameters/input_boost_ms 1000
    	write /sys/class/kgsl/kgsl-3d0/idle_timer 80
    	write /sys/class/kgsl/kgsl-3d0/max_gpuclk 650000000
    	write /sys/class/kgsl/kgsl-3d0/devfreq/max_freq 650000000
    	write /sys/class/kgsl/kgsl-3d0/devfreq/min_freq 133330000
    	write /sys/class/kgsl/kgsl-3d0/min_clock_mhz 133
    	write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 5
    	write /sys/devices/soc/soc:qcom,cpubw/devfreq/soc:qcom,cpubw/governor bw_hwmon
    	write /sys/devices/soc/soc:qcom,cpubw/devfreq/soc:qcom,cpubw/max_freq 7104
    	write /sys/devices/soc/soc:qcom,cpubw/devfreq/soc:qcom,cpubw/min_freq 769
    	write /sys/devices/soc/soc:qcom,mincpubw/devfreq/soc:qcom,mincpubw/governor cpufreq
    	write /sys/devices/soc/soc:qcom,mincpubw/devfreq/soc:qcom,mincpubw/max_freq 5859
    	write /sys/devices/soc/soc:qcom,mincpubw/devfreq/soc:qcom,mincpubw/min_freq 1611
	set_default_thermal_zones;
    	write /sys/class/leds/lcd-backlight/max_brightness 255
    elif [[ $spectrum_profile -eq 1 ]]; then
    	write /sys/module/workqueue/parameters/power_efficient Y
    	write /sys/devices/system/cpu/cpufreq/conservative/up_threshold 85
    	write /sys/devices/system/cpu/cpufreq/conservative/down_threshold 30
    	write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 2208000
    	write /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq 652800
    	write /sys/module/cpu_boost/parameters/input_boost_freq 1401600
    	write /sys/module/cpu_boost/parameters/input_boost_ms 1250
    	write /sys/class/kgsl/kgsl-3d0/idle_timer 80
    	write /sys/class/kgsl/kgsl-3d0/max_gpuclk 650000000
    	write /sys/class/kgsl/kgsl-3d0/devfreq/max_freq 650000000
    	write /sys/class/kgsl/kgsl-3d0/devfreq/min_freq 133330000
    	write /sys/class/kgsl/kgsl-3d0/min_clock_mhz 133
    	write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 5
    	write /sys/devices/soc/soc:qcom,cpubw/devfreq/soc:qcom,cpubw/governor bw_hwmon
    	write /sys/devices/soc/soc:qcom,cpubw/devfreq/soc:qcom,cpubw/max_freq 7104
    	write /sys/devices/soc/soc:qcom,cpubw/devfreq/soc:qcom,cpubw/min_freq 1611
    	write /sys/devices/soc/soc:qcom,mincpubw/devfreq/soc:qcom,mincpubw/governor cpufreq
    	write /sys/devices/soc/soc:qcom,mincpubw/devfreq/soc:qcom,mincpubw/max_freq 7104
    	write /sys/devices/soc/soc:qcom,mincpubw/devfreq/soc:qcom,mincpubw/min_freq 1611
    	write /sys/kernel/msm_thermal/enabled 0
    	write /sys/kernel/msm_thermal/zone0 "2208000 44 43"
    	write /sys/kernel/msm_thermal/zone1 "2016000 45 43"
    	write /sys/kernel/msm_thermal/zone2 "1804800 46 45"
    	write /sys/kernel/msm_thermal/zone3 "1689600 47 43"
    	write /sys/kernel/msm_thermal/zone4 "1401600 52 50"
    	write /sys/kernel/msm_thermal/zone5 "1036800 54 52"
    	write /sys/kernel/msm_thermal/zone6 "0 0 0"
    	write /sys/kernel/msm_thermal/zone7 "0 0 0"
    	write /sys/kernel/msm_thermal/zone8 "0 0 0"
    	write /sys/kernel/msm_thermal/sampling_ms 3000
    	write /sys/kernel/msm_thermal/enabled 1
    	write /sys/class/leds/lcd-backlight/max_brightness 255
    elif [[ $spectrum_profile -eq 2 ]]; then
    	write /sys/module/workqueue/parameters/power_efficient Y
    	write /sys/devices/system/cpu/cpufreq/conservative/up_threshold 95
    	write /sys/devices/system/cpu/cpufreq/conservative/down_threshold 35
    	write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 1689600
    	write /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq 652800
    	write /sys/module/cpu_boost/parameters/input_boost_freq 1036800
    	write /sys/module/cpu_boost/parameters/input_boost_ms 750
    	write /sys/class/kgsl/kgsl-3d0/idle_timer 64
    	write /sys/class/kgsl/kgsl-3d0/max_gpuclk 560000000
    	write /sys/class/kgsl/kgsl-3d0/devfreq/max_freq 560000000
    	write /sys/class/kgsl/kgsl-3d0/devfreq/min_freq 133330000
    	write /sys/class/kgsl/kgsl-3d0/min_clock_mhz 133
    	write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 5
    	write /sys/devices/soc/soc:qcom,cpubw/devfreq/soc:qcom,cpubw/governor bw_hwmon
    	write /sys/devices/soc/soc:qcom,cpubw/devfreq/soc:qcom,cpubw/max_freq 6445
    	write /sys/devices/soc/soc:qcom,cpubw/devfreq/soc:qcom,cpubw/min_freq 769
    	write /sys/devices/soc/soc:qcom,mincpubw/devfreq/soc:qcom,mincpubw/governor cpufreq
    	write /sys/devices/soc/soc:qcom,mincpubw/devfreq/soc:qcom,mincpubw/max_freq 5859
    	write /sys/devices/soc/soc:qcom,mincpubw/devfreq/soc:qcom,mincpubw/min_freq 769
    	write /sys/kernel/msm_thermal/enabled 0
    	write /sys/kernel/msm_thermal/zone0 "1689600 45 44"
    	write /sys/kernel/msm_thermal/zone1 "1401600 50 48"
    	write /sys/kernel/msm_thermal/zone2 "1036800 52 50"
    	write /sys/kernel/msm_thermal/zone3 "652800 54 52"
    	write /sys/kernel/msm_thermal/zone4 "0 0 0"
    	write /sys/kernel/msm_thermal/zone5 "0 0 0"
    	write /sys/kernel/msm_thermal/zone6 "0 0 0"
    	write /sys/kernel/msm_thermal/zone7 "0 0 0"
    	write /sys/kernel/msm_thermal/zone8 "0 0 0"
    	write /sys/kernel/msm_thermal/sampling_ms 3000
    	write /sys/kernel/msm_thermal/enabled 1
    	write /sys/class/leds/lcd-backlight/max_brightness 127
    else [[ $spectrum_profile -eq 3 ]];
    	write /sys/module/workqueue/parameters/power_efficient N
    	write /sys/devices/system/cpu/cpufreq/conservative/up_threshold 80
    	write /sys/devices/system/cpu/cpufreq/conservative/down_threshold 20
    	write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 2208000
    	write /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq 1036800
    	write /sys/module/cpu_boost/parameters/input_boost_freq 1689600
    	write /sys/module/cpu_boost/parameters/input_boost_ms 1500
    	echo "performance" > /sys/class/kgsl/kgsl-3d0/devfreq/governor
    	write /sys/class/kgsl/kgsl-3d0/idle_timer 1000000
    	write /sys/class/kgsl/kgsl-3d0/max_gpuclk 725000000
    	write /sys/class/kgsl/kgsl-3d0/devfreq/max_freq 725000000
    	write /sys/class/kgsl/kgsl-3d0/devfreq/min_freq 725000000
    	write /sys/class/kgsl/kgsl-3d0/min_clock_mhz 725
    	write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 0
    	write /sys/devices/soc/soc:qcom,cpubw/devfreq/soc:qcom,cpubw/governor bw_hwmon
    	write /sys/devices/soc/soc:qcom,cpubw/devfreq/soc:qcom,cpubw/max_freq 7104
    	write /sys/devices/soc/soc:qcom,cpubw/devfreq/soc:qcom,cpubw/min_freq 4248
    	write /sys/devices/soc/soc:qcom,mincpubw/devfreq/soc:qcom,mincpubw/governor bw_hwmon
    	write /sys/devices/soc/soc:qcom,mincpubw/devfreq/soc:qcom,mincpubw/max_freq 7104
    	write /sys/devices/soc/soc:qcom,mincpubw/devfreq/soc:qcom,mincpubw/min_freq 7104
    	write /sys/kernel/msm_thermal/enabled 0
    	write /sys/kernel/msm_thermal/zone0 "2208000 46 45"
    	write /sys/kernel/msm_thermal/zone1 "2016000 48 46"
    	write /sys/kernel/msm_thermal/zone2 "1958400 50 48"
    	write /sys/kernel/msm_thermal/zone3 "1804800 51 49"
    	write /sys/kernel/msm_thermal/zone4 "1689600 52 50"
    	write /sys/kernel/msm_thermal/zone5 "1036800 56 52"
    	write /sys/kernel/msm_thermal/zone6 "0 0 0"
    	write /sys/kernel/msm_thermal/zone7 "0 0 0"
    	write /sys/kernel/msm_thermal/zone8 "0 0 0"
    	write /sys/kernel/msm_thermal/sampling_ms 3000
    	write /sys/kernel/msm_thermal/enabled 1
    	write /sys/class/leds/lcd-backlight/max_brightness 225
    fi
else
    set_default_thermal_zones;
fi
