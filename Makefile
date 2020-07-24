.PHONY: build
VERSION = v0.10.0

images/ubuntu-20.04-preinstalled-server-arm64+raspi.img:
	curl -L http://cdimage.ubuntu.com/releases/20.04/release/ubuntu-20.04-preinstalled-server-arm64+raspi.img.xz | unxz > $@

images/k3os-rootfs-arm.tar.gz:
	rm -f $@
	curl -L https://github.com/rancher/k3os/releases/download/$(VERSION)/k3os-rootfs-arm.tar.gz > $@

k3os-ubuntu-overlay.img: k3os-ubuntu-overlay.json images/k3os-rootfs-arm.tar.gz images/ubuntu-20.04-preinstalled-server-arm64+raspi.img
	docker-compose run packer_builder_arm build k3os-ubuntu-overlay.json

build: k3os-ubuntu-overlay.img