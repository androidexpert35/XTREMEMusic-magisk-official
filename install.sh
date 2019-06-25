##########################################################################################
#
# Magisk Module Template Config Script
# by topjohnwu
#
##########################################################################################
##########################################################################################
#
# Instructions:
#
# 1. Place your files into system folder (delete the placeholder file)
# 2. Fill in your module's info into module.prop
# 3. Configure the settings in this file (config.sh)
# 4. If you need boot scripts, add them into common/post-fs-data.sh or common/service.sh
# 5. Add your additional or modified system properties into common/system.prop
#
##########################################################################################

##########################################################################################
# Configs
##########################################################################################

# Set to true if you need to enable Magic Mount
# Most mods would like it to be enabled
SKIPMOUNT=false

# Set to true if you need to load system.prop
PROPFILE=true

# Set to true if you need post-fs-data script
POSTFSDATA=false

# Set to true if you need late_start service script
LATESTARTSERVICE=false

##########################################################################################
# Installation Message
##########################################################################################

# Set what you want to show when installing your mod

print_modname() {
  ui_print "******************************"
  ui_print "|     By: androidexpert35    |"
  ui_print "|       @XDA Developers      |"
  ui_print "******************************"
  ui_print "|                            |"
  ui_print "|        XTREMEMusic™        |"
  ui_print "|                            |"
  ui_print "|       Version: 9.4.2       |"
  ui_print "|                            |"
  ui_print "******************************"
  ui_print " "
}

##########################################################################################
# Replace list
##########################################################################################

# List all directories you want to directly replace in the system
# Check the documentations for more info about how Magic Mount works, and why you need this

# Construct your own list here, it will override the example above
# !DO NOT! remove this if you don't need to replace anything, leave it empty as it is now
REPLACE="
/system/etc/audio_effect.conf
/system/vendor/etc/audio_effect.conf
/system/usr/share/alsa
"

on_install() {
  # The following is the default implementation: extract $ZIPFILE/system to $MODPATH
  # Extend/change the logic to whatever you want
  unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
}

##########################################################################################
# Permissions
##########################################################################################

set_permissions() {
  # Only some special files require specific permissions
  # The default permissions should be good enough for most cases

  # Here are some examples for the set_perm functions:

  # set_perm_recursive  <dirname>                <owner> <group> <dirpermission> <filepermission> <contexts> (default: u:object_r:system_file:s0)
  # set_perm_recursive  $MODPATH$MODPATH/system/lib       0       0       0755            0644

  # set_perm  <filename>                         <owner> <group> <permission> <contexts> (default: u:object_r:system_file:s0)
  # set_perm  $MODPATH$MODPATH/system/bin/app_process32   0       2000    0755         u:object_r:zygote_exec:s0
  # set_perm  $MODPATH$MODPATH/system/bin/dex2oat         0       2000    0755         u:object_r:dex2oat_exec:s0
  # set_perm  $MODPATH$MODPATH/system/lib/libart.so       0       0       0644

  # The following is default permissions, DO NOT remove
  set_perm_recursive  $MODPATH  0  0  0755  0644
  set_perm_recursive  $MODPATH/system/bin  0  2000  0755  0755
}

##########################################################################################
# Custom Functions
##########################################################################################

# This file (config.sh) will be sourced by the main flash script after util_functions.sh
# If you need custom logic, please add them here as functions, and call these functions in
# update-binary. Refrain from adding code directly into update-binary, as it will make it
# difficult for you to migrate your modules to newer template versions.
# Make update-binary as clean as possible, try to only do function calls in it.

extract_xm(){
unzip -o "$ZIPFILE" 'XTREME/*' -d $TMPDIR >&2
if [ ! -e $TMPDIR/XTREME ]; 
then
ui_print "- Error while running intelligent installation!"
ui_print "- SoundMod only partially installed!"
exit 1
fi
}
set_xtreme() {

   mkdir -p $MODPATH/system/vendor/lib/soundfx
   mkdir -p $MODPATH/system/lib/soundfx

if [ -e /system/framework/com.sony.device.jar ]; 
then
   cp -f /dev/tmp/XTREME/Supported/samsung/lib/* $MODPATH/system/lib/
   cp -f /dev/tmp/XTREME/Supported/samsung/vendor/* $MODPATH/system/vendor/lib/
   cp -f /dev/tmp/XTREME/Supported/lib/liblgaudioutils.so $MODPATH/system/lib/
   cp -f /dev/tmp/XTREME/Supported/lib/liblgresampler.so $MODPATH/system/lib/
   cp -f /dev/tmp/XTREME/Supported/huawei/vendor/* $MODPATH/system/vendor/lib/
   cp -f /dev/tmp/XTREME/Supported/huawei/lib/* $MODPATH/system/lib/
   cp -f /dev/tmp/XTREME/Supported/framework/* $MODPATH/system/framework/
   cp -f /dev/tmp/XTREME/Supported/etc/diracmobile.config $MODPATH/system/vendor/etc/
   cp -f /dev/tmp/XTREME/Supported/lib/libDiracAPI_SHARED.so $MODPATH/system/lib/
   mkdir -p $MODPATH/system/customize
   mkdir -p $MODPATH/system/customize/ACC
   cp -f /dev/tmp/XTREME/Supported/etc/default.xml $MODPATH/system/customize/ACC/
elif [ $(grep ro.product.brand=htc /system/build.prop) ];
then
   cp -f /dev/tmp/XTREME/Supported/samsung/lib/* $MODPATH/system/lib/
   cp -f /dev/tmp/XTREME/Supported/samsung/vendor/* $MODPATH/system/vendor/lib/
   cp -f /dev/tmp/XTREME/Supported/lib/liblgaudioutils.so $MODPATH/system/lib/
   cp -f /dev/tmp/XTREME/Supported/lib/liblgresampler.so $MODPATH/system/lib/
   cp -f /dev/tmp/XTREME/Supported/sony/framework/* $MODPATH/system/framework/
   cp -f /dev/tmp/XTREME/Supported/sony/lib/* $MODPATH/system/lib/
   cp -f /dev/tmp/XTREME/Supported/framework/* $MODPATH/system/framework/
   cp -f /dev/tmp/XTREME/Supported/huawei/vendor/* $MODPATH/system/vendor/lib/
   cp -f /dev/tmp/XTREME/Supported/huawei/lib/* $MODPATH/system/lib/
   cp -f /dev/tmp/XTREME/Supported/etc/diracmobile.config $MODPATH/system/vendor/etc/
   cp -f /dev/tmp/XTREME/Supported/lib/libDiracAPI_SHARED.so $MODPATH/system/lib/
elif [ $(grep ro.product.brand=huawei /system/build.prop) ];
then
   cp -f /dev/tmp/XTREME/Supported/samsung/lib/* $MODPATH/system/lib/
   cp -f /dev/tmp/XTREME/Supported/samsung/soundfx/libaudiosa.so /vendor/lib/soundfx/
   cp -f /dev/tmp/XTREME/Supported/samsung/vendor/* $MODPATH/system/vendor/lib/
   cp -f /dev/tmp/XTREME/Supported/lib/liblgaudioutils.so $MODPATH/system/lib/
   cp -f /dev/tmp/XTREME/Supported/lib/liblgresampler.so $MODPATH/system/lib/
   cp -f /dev/tmp/XTREME/Supported/sony/framework/* $MODPATH/system/framework/
   cp -f /dev/tmp/XTREME/Supported/sony/lib/* $MODPATH/system/lib/
   cp -f /dev/tmp/XTREME/Supported/framework/* $MODPATH/system/framework/
   cp -f /dev/tmp/XTREME/Supported/etc/diracmobile.config $MODPATH/system/vendor/etc/
   cp -f /dev/tmp/XTREME/Supported/lib/libDiracAPI_SHARED.so $MODPATH/system/lib/
   mkdir -p $MODPATH/system/customize
   mkdir -p $MODPATH/system/customize/ACC
   cp -f /dev/tmp/XTREME/Supported/etc/default.xml $MODPATH/system/customize/ACC/
elif [ -e /system/framework/framework-ext-res/framework-ext-res.apk ]; 
then
   cp -f /dev/tmp/XTREME/Supported/framework/* $MODPATH/system/framework/
elif [ $(grep ro.product.brand=lge /system/build.prop) ];
then
   cp -f /dev/tmp/XTREME/Supported/samsung/lib/* $MODPATH/system/lib/
   cp -f /dev/tmp/XTREME/Supported/samsung/soundfx/libaudiosa.so /vendor/lib/soundfx/
   cp -f /dev/tmp/XTREME/Supported/samsung/vendor/* $MODPATH/system/vendor/lib/
   cp -f /dev/tmp/XTREME/Supported/samsung/vendor/* /vendor/lib/
   cp -f /dev/tmp/XTREME/Supported/sony/framework/* $MODPATH/system/framework/
   cp -f /dev/tmp/XTREME/Supported/sony/lib/* $MODPATH/system/lib/
   cp -f /dev/tmp/XTREME/Supported/huawei/vendor/* $MODPATH/system/vendor/lib/
   cp -f /dev/tmp/XTREME/Supported/huawei/lib/* $MODPATH/system/lib/
   cp -f /dev/tmp/XTREME/Supported/framework/* $MODPATH/system/framework/
   cp -f /dev/tmp/XTREME/Supported/etc/diracmobile.config $MODPATH/system/vendor/etc/
   cp -f /dev/tmp/XTREME/Supported/lib/libDiracAPI_SHARED.so $MODPATH/system/lib/
   mkdir -p $MODPATH/system/customize
   mkdir -p $MODPATH/system/customize/ACC
   cp -f /dev/tmp/XTREME/Supported/etc/default.xml $MODPATH/system/customize/ACC/
elif [ $(grep ro.product.brand=motorola /system/build.prop) ];
then
   cp -f /dev/tmp/XTREME/Supported/samsung/lib/* $MODPATH/system/lib/
   cp -f /dev/tmp/XTREME/Supported/samsung/soundfx/libaudiosa.so /vendor/lib/soundfx/
   cp -f /dev/tmp/XTREME/Supported/samsung/vendor/* $MODPATH/system/vendor/lib/
   cp -f /dev/tmp/XTREME/Supported/lib/liblgaudioutils.so $MODPATH/system/lib/
   cp -f /dev/tmp/XTREME/Supported/lib/liblgresampler.so $MODPATH/system/lib/
   cp -f /dev/tmp/XTREME/Supported/sony/framework/* $MODPATH/system/framework/
   cp -f /dev/tmp/XTREME/Supported/sony/lib/* $MODPATH/system/lib/
   cp -f /dev/tmp/XTREME/Supported/framework/* $MODPATH/system/framework/
   cp -f /dev/tmp/XTREME/Supported/etc/diracmobile.config $MODPATH/system/vendor/etc/
   cp -f /dev/tmp/XTREME/Supported/lib/libDiracAPI_SHARED.so $MODPATH/system/lib/
   mkdir -p $MODPATH/system/customize
   mkdir -p $MODPATH/system/customize/ACC
   cp -f /dev/tmp/XTREME/Supported/etc/default.xml $MODPATH/system/customize/ACC/
elif [ -e /system/framework/twframework-res.apk ]; 
then
   cp -f /dev/tmp/XTREME/Supported/sony/framework/* $MODPATH/system/framework/
   cp -f /dev/tmp/XTREME/Supported/huawei/vendor/* $MODPATH/system/vendor/lib/
   cp -f /dev/tmp/XTREME/Supported/huawei/lib/* $MODPATH/system/lib/
   cp -f /dev/tmp/XTREME/Supported/sony/lib/* $MODPATH/system/lib/
   cp -f /dev/tmp/XTREME/Supported/etc/diracmobile.config $MODPATH/system/vendor/etc/
   cp -f /dev/tmp/XTREME/Supported/lib/libDiracAPI_SHARED.so $MODPATH/system/lib/
   mkdir -p $MODPATH/system/customize
   mkdir -p $MODPATH/system/customize/ACC
   cp -f /dev/tmp/XTREME/Supported/etc/default.xml $MODPATH/system/customize/ACC/
elif [ $(grep ro.product.brand=Leeco /system/build.prop) ];
then
   cp -f /dev/tmp/XTREME/Supported/framework/* $MODPATH/system/framework/
elif [ $(grep ro.product.brand=google /system/build.prop) ];
then
   cp -f /dev/tmp/XTREME/Supported/samsung/lib/* $MODPATH/system/lib/
   cp -f /dev/tmp/XTREME/Supported/samsung/vendor/* $MODPATH/system/vendor/lib/
   cp -f /dev/tmp/XTREME/Supported/lib/liblgaudioutils.so $MODPATH/system/lib/
   cp -f /dev/tmp/XTREME/Supported/lib/liblgresampler.so $MODPATH/system/lib/
   cp -f /dev/tmp/XTREME/Supported/sony/framework/* $MODPATH/system/framework/
   cp -f /dev/tmp/XTREME/Supported/sony/lib/* $MODPATH/system/lib/
   cp -f /dev/tmp/XTREME/Supported/huawei/vendor/* $MODPATH/system/vendor/lib/
   cp -f /dev/tmp/XTREME/Supported/huawei/lib/* $MODPATH/system/lib/
   cp -f /dev/tmp/XTREME/Supported/framework/* $MODPATH/system/framework/
   cp -f /dev/tmp/XTREME/Supported/etc/diracmobile.config $MODPATH/system/vendor/etc/
   cp -f /dev/tmp/XTREME/Supported/lib/libDiracAPI_SHARED.so $MODPATH/system/lib/
   mkdir -p $MODPATH/system/customize
   mkdir -p $MODPATH/system/customize/ACC
   cp -f /dev/tmp/XTREME/Supported/etc/default.xml $MODPATH/system/customize/ACC/
fi

}

set_oreo() {
if [ $(grep ro.build.version.sdk=26 /system/build.prop) ] || [ $(grep ro.build.version.sdk=27 /system/build.prop) ] || [ $(grep ro.build.version.sdk=28 /system/build.prop) ] || [ $(grep ro.build.version.sdk=29 /system/build.prop) ];
then
cp -f /dev/tmp/XTREME/Supported/universal/soundfx/* $MODPATH/system/vendor/lib/soundfx/
cp -f /dev/tmp/XTREME/Supported/oreo/etc/* $MODPATH/system/etc/
cp -f /dev/tmp/XTREME/Supported/oreo/vendor/* $MODPATH/system/vendor/etc/
else
cp -f /dev/tmp/XTREME/Supported/universal/soundfx/* $MODPATH/system/lib/soundfx/
cp -f /dev/tmp/XTREME/Supported/etc/* $MODPATH/system/etc/
cp -f /dev/tmp/XTREME/Supported/vendor/etc/* $MODPATH/system/vendor/etc/
fi
}

set_special_libs() {
if [ $(grep ro.build.version.sdk=26 /system/build.prop) ] || [ $(grep ro.build.version.sdk=27 /system/build.prop) ] || [ $(grep ro.build.version.sdk=28 /system/build.prop) ] || [ $(grep ro.build.version.sdk=29 /system/build.prop) ] && [ ! -e /system/framework/twframework-res.apk ];
then
   cp -f /dev/tmp/XTREME/Supported/samsung/soundfx/* $MODPATH/system/vendor/lib/soundfx/
fi
if [ $(grep ro.build.version.sdk=26 /system/build.prop) ] || [ $(grep ro.build.version.sdk=27 /system/build.prop) ] || [ $(grep ro.build.version.sdk=28 /system/build.prop) ] || [ $(grep ro.build.version.sdk=29 /system/build.prop) ] &&  [ ! -e /system/framework/com.sony.device.jar ];
then
   cp -f /dev/tmp/XTREME/Supported/sony/soundfx/* $MODPATH/system/vendor/lib/soundfx/
fi
}

set_64bit() {

if [ -e /system/vendor/lib/libadreno_utils.so ] || [ -e /vendor/lib/libadreno_utils.so ];
then
:
elif [ -e /system/lib64/soundfx/libeffectproxy.so ];
then
   cp -f /dev/tmp/XTREME/Supported/qualcomm/lib64/* $MODPATH/system/lib64/soundfx/
   cp -f /dev/tmp/XTREME/Supported/qualcomm/vendor64/* $MODPATH/system/vendor/lib64/soundfx/
elif [ -e /system/vendor/lib/soundfx/libqcbassboost.so ];
then
   cp -f /dev/tmp/XTREME/Supported/qualcomm/lib/* $MODPATH/system/lib/
   cp -f /dev/tmp/XTREME/Supported/qualcomm/vendor/* $MODPATH/system/vendodr/lib/soundfx
fi
}
