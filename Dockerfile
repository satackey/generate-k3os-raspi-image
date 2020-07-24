FROM mkaczanowski/packer-builder-arm

RUN set -x && \
    apt-get update && apt-get -y install \
        xz-utils
