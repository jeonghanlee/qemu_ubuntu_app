#!/bin/sh
# Phoebus launcher for Mac OS X
# Original code comes from 
# https://github.com/kasemir/phoebus-sns/blob/master/app_template/Contents/MacOS/main.command
# 
# Location of this script
# cd .. pwd determines the full path
# even if called from shell with relative path
# 
#
TOP="$( cd "$(dirname "$0")" || exit ; pwd -P )"

QEMU="${TOP}/qemu_src/build"
DRIVE="${TOP}/drive"

PATH="$QEMU:$PATH"

export PATH

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
  -drive file="${DRIVE}"/ubuntu.qcow2,if=virtio,cache=writethrough \
  -cdrom "${DRIVE}"/ubuntu-20.04.2-live-server-arm64.iso
