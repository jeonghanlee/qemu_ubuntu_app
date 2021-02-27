# Ubuntu 20.04, QEMU on Apple Silicon Mac

## QEMU


```bash
$ sudo port install ninja pkgconfig glib2 pixman wget

$ pwd
/Users/JeongLee/github/qemu_ubuntu_app

$ git clone https://git.qemu.org/git/qemu.git qemu_src

$ cd qemu-src
git checkout d0dddab40e -b wip/hvf
curl 'https://patchwork.kernel.org/series/418581/mbox/'|git am --3way

$ mkdir build
$ cd build
$ ../configure --target-list=aarch64-softmmu --enable-cocoa
$ make -j

$ ./qemu-img create -f qcow2 ../../drive/ubuntu.qcow2 40G 

$ cd ../../drive
$ wget -c https://gist.github.com/niw/4f1f9bb572f40d406866f23b3127919b/raw/f546faea68f4149c06cca88fa67ace07a3758268/QEMU_EFI-cb438b9-edk2-stable202011-with-extra-resolutions.tar.gz
$ tar xzvf QEMU_EFI-*.tar.gz
$ dd if=/dev/zero of=pflash0.img bs=1m count=64
$ dd if=/dev/zero of=pflash1.img bs=1m count=64
$ dd if=QEMU_EFI.fd of=pflash0.img conv=notrunc
$ dd if=QEMU_VARS.fd of=pflash1.img conv=notrunc
$ wget -c https://cdimage.ubuntu.com/releases/20.04/release/ubuntu-20.04.2-live-server-arm64.iso
$ cd ..
$ sh install_ubuntu.sh

```

```bash
$ pwd
/Users/JeongLee/github/qemu_ubuntu_app

$ rm -f drive/*.tgz
$ rm -f drive/*.fd
$ rm -f drive/*.iso
$ sudo mkdir /Applications/QEMU_Ubuntu.app
$ sudo ditto * /Applications/QEMU_Ubuntu.app
```
 

