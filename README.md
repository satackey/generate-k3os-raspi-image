# generate-k3os-raspi-image

```shell
$ git clone https://github.com/satackey/generate-k3os-raspi-image.git
$ cd generate-k3os-raspi-image

$ cp k3os-system-config.sample.yaml k3os-system-config.yaml

$ # Configure.
$ vim k3os-system-config.yaml

$ make build

$ # Specify the version.
$ make VERSION=v0.10.0 build

$ # Force rebuild.
$ make rebuild
```

## Requirements

- Docker / Docker Compose
- curl
- unxz
- GNU Make
