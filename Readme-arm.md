
https://www.reddit.com/r/docker/comments/c75uhq/how_to_run_arm64_containers_from_amd64_hosts_and/
https://github.com/multiarch/qemu-user-static/releases
---

docker run --rm --privileged multiarch/qemu-user-static:register
sudo -s
wget https://github.com/multiarch/qemu-user-static/releases/download/v6.1.0-8/qemu-aarch64-static -O /usr/bin/qemu-aarch64-static

docker run -v /usr/bin/qemu-aarch64-static:/usr/bin/qemu-aarch64-static -it --platform linux/arm64 quay.io/centos/centos:stream8 bash


docker buildx build --platform arm64 -t twisted/centos8-arm64  --load --progress plain .

docker run -v /usr/bin/qemu-aarch64-static:/usr/bin/qemu-aarch64-static -ti --rm twisted/centos8-arm64


# # # activate arm64

docker run --rm --privileged multiarch/qemu-user-static --reset -p yes