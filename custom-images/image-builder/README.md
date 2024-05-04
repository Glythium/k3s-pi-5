# Image Builder

This Dockerfile is used to build the image that builds the other images. It's kept separated here for these reasons:
- This image needs to exist before the other images
- I can't get `kaniko` to build a new image containing `kaniko`
- `kaniko` wants to run as `root`, whereas I want to have the other images run as a non-privileged user

### Building the Builder
```bash
docker build -f image-builder.Dockerfile -t <TAG> --platform=<ARCH> .
```