# Le Paulynomial Homelab

This project has been forked from
[template-cluster-k3s](https://github.com/k8s-at-home/template-cluster-k3s).
Thank y'all for for the inspiration.

## Publishing arm64 images

### Cloudflared (Argo Tunnel)

```bash
docker \
  buildx \
    build \
      --platform linux/arm64 \
      -t ghcr.io/paulkiernan/cloudflared:2021.8.7-arm64 \
      --push \
      .
```
