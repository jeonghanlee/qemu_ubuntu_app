#!/bin/sh
# Phoebus launcher for Mac OS X
# Original code comes from 
# https://github.com/kasemir/phoebus-sns/blob/master/app_template/Contents/MacOS/main.command
# 
# Modified Version Feb 20, 2021
# Jeong Han Lee
#
# Location of this script
# cd .. pwd determines the full path
# even if called from shell with relative path
# 
MACOS="$( cd "$(dirname "$0")" || exit ; pwd -P )"
BASE=${MACOS%/*/*}

# QEMU TOP
TOP="${BASE}/QEMU"
CONTENTS="${BASE}/Contents"
DRIVE="${BASE}/drive"

PATH="$TOP:$PATH"
HOSTNAME=$(/bin/hostname)

export PATH

ICNS_FILE="${CONTENTS}/Resources/ubuntu-mac.icns"
DOCK_NAME="QEMU Ubuntu"

qemu-system-aarch64 \
  -monitor stdio \
  -M virt,highmem=off \
  -accel hvf \
  -cpu cortex-a72 \
  -smp 4 \
  -m 4096 \
  -drive file="${DRIVE}"/pflash0.img,format=raw,if=pflash,readonly=on \
  -drive file="${DRIVE}"/pflash1.img,format=raw,if=pflash \
  -device virtio-gpu-pci \
  -display default,show-cursor=on \
  -audiodev id=none,driver=none \
  -vga std \
  -device qemu-xhci \
  -device usb-kbd \
  -device usb-tablet \
  -device intel-hda \
  -device hda-duplex \
  -drive file="${DRIVE}"/ubuntu.qcow2,if=virtio,cache=writethrough

