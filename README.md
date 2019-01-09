# remarkableas/packer-arm

A simple container taking the [official Packer Docker Container from Hashicorp](https://hub.docker.com/r/hashicorp/packer/), 
and then adding [solo-io's ARM plugin](https://github.com/solo-io/packer-builder-arm-image).

This image is a bit of a quick and dirty fix, so it hasn't been slimmed down. The ARM plugin also uses low-level OS manipulations,
meaning the container needs to run in privileged mode, so you probably want to run it in a VM or similar.

Usage:

```sh
docker run -it --rm -v $PWD:/work --privileged remarkableas/packer-arm build my-packer-script.json
```
