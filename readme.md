```sh
podman build . -t build-uboot
podman run -it localhost/build-uboot bash
podman cp container_name:/build/outbin ./
picocom -b 1500000 -d 8 /dev/cu.SLAB_USBtoUART
```
