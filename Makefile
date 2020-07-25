.PHONY: build remove rebuild destroy

VERSION = v0.10.0
K3OS_SYSTEM_CONFIG = k3os-system-config.yaml
K3OS_ROOTFS_PATH = images/k3os-$(VERSION)-rootfs-arm.tar.gz
IMAGE_DEST = k3os-$(VERSION)-ubuntu-overlay.img

images:
	mkdir -p images

images/ubuntu-20.04-preinstalled-server-arm64+raspi.img: images
	curl -L http://cdimage.ubuntu.com/releases/20.04/release/ubuntu-20.04-preinstalled-server-arm64+raspi.img.xz | unxz > $@

$(K3OS_ROOTFS_PATH): images
	rm -f $@
	curl -L https://github.com/rancher/k3os/releases/download/$(VERSION)/k3os-rootfs-arm.tar.gz > $@

$(IMAGE_DEST): k3os-ubuntu-overlay.json $(K3OS_ROOTFS_PATH) images/ubuntu-20.04-preinstalled-server-arm64+raspi.img
	docker-compose run --rm \
		-e K3OS_ROOTFS_PATH=$(K3OS_ROOTFS_PATH) \
		-e K3OS_SYSTEM_CONFIG=$(K3OS_SYSTEM_CONFIG) \
		-e IMAGE_DEST=$@ \
		packer_builder_arm build k3os-ubuntu-overlay.json

build: $(IMAGE_DEST)

remove:
	rm -f $(IMAGE_DEST)

rebuild: remove build

destroy:
	rm -rf images k3os-*-ubuntu-overlay.img
