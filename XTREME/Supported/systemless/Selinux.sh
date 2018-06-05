#!/system/bin/sh
# Copyright (C) 2015 Paget96
# Thank you Paget96 For the script
#=======================================================================#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.
#=======================================================================#

mount -o remount,rw / 2>/dev/null
mount -o remount,rw / / 2>/dev/null
mount -o remount,rw rootfs 2>/dev/null
mount -o remount,rw /system 2>/dev/null
mount -o remount,rw /system /system 2>/dev/null
busybox mount -o remount,rw / 2>/dev/null
busybox mount -o remount,rw / / 2>/dev/null
busybox mount -o remount,rw rootfs 2>/dev/null
busybox mount -o remount,rw /system 2>/dev/null
busybox mount -o remount,rw /system /system 2>/dev/null

busybox chmod 666 /sys/fs/selinux/enforce
setenforce 0
busybox echo "0" > /sys/fs/selinux/enforce
busybox chmod 444 /sys/fs/selinux/enforce

mount -o remount,ro / 2>/dev/null
mount -o remount,ro / / 2>/dev/null
mount -o remount,ro rootfs 2>/dev/null
mount -o remount,ro /system 2>/dev/null
mount -o remount,ro /system /system 2>/dev/null
busybox mount -o remount,ro / 2>/dev/null
busybox mount -o remount,ro / / 2>/dev/null
busybox mount -o remount,ro rootfs 2>/dev/null
busybox mount -o remount,ro /system 2>/dev/null
busybox mount -o remount,ro /system /system 2>/dev/null

