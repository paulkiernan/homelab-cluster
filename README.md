# Le Paulynomial Homelab

This project has been forked from
[template-cluster-k3s](https://github.com/k8s-at-home/template-cluster-k3s).
Thank y'all for for the inspiration.

## Publishing arm64 images

Most of the projects have github workflows that will automatically do this, but
in case this needs to be done manually you can follow these instructions to
build multiarch docker images:

First of all, we need to add arm64 as an available build target from an x86
host. We can verify that arm64 targets are missing via:

```console
# Verify that no arm64 local build env exists
$ docker buildx ls

# Start the buildx qemu environment
$ docker \
  run \
    --rm \
    --privileged \
    docker/binfmt:a7996909642ee92942dcd6cff44b9b95f08dad64

# Verify that new build environments have been added
$ docker buildx ls
NAME/NODE DRIVER/ENDPOINT STATUS  PLATFORMS
default * docker
  default default         running linux/amd64, linux/386, linux/arm64, linux/riscv64, linux/ppc64le, linux/s390x, linux/arm/v7, linux/arm/v6
```

#### Login to the Github Container Registry
[docs}(https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry)

### Cloudflared (Argo Tunnel)

```bash
# Build the image for cloudflared
docker \
  buildx \
    build \
      --platform linux/arm64 \
      -t ghcr.io/paulkiernan/cloudflared:2021.8.7-arm64 \
      --push \
      .
```
