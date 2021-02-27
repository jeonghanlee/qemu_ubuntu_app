#!/bin/sh
# References, please see README.md
# 
# Jeong Han Lee
# jeonghan.lee@gmail.com 
# Feb 26, 2021
#
#

MACOS="$( cd "$(dirname "$0")" || exit ; pwd -P )"
TOP=${MACOS%/*/*}

# 
QEMU="${TOP}/qemu"
CONTENTS="${TOP}/Contents"
DRIVE="${TOP}/drive"

PATH="${QEMU}:$PATH"

export PATH

ICNS_FILE="${CONTENTS}/Resources/ubuntu-mac.icns"
DOCK_NAME="QEMU Ubuntu 20.04"

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

