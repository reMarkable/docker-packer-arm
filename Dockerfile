FROM hashicorp/packer:full
LABEL maintainer="henrik.hedlund@remarkable.com"

# Install dependencies
RUN apk update && \
    apk add multipath-tools && \
    apk add e2fsprogs && \
    apk add e2fsprogs-extra && \
    go get -u github.com/golang/dep/cmd/dep

# As qemu-arm-static doesn't seem to be distributed for Alpine, download it directly from multiarch's Github repo
RUN wget https://github.com/multiarch/qemu-user-static/releases/download/v3.1.0-2/qemu-arm-static -P /usr/local/bin && \
    chmod +x /usr/local/bin/qemu-arm-static

# Download, build & install the Packer ARM plugin
RUN mkdir -p $GOPATH/src/github.com/solo-io/ && \
    cd $GOPATH/src/github.com/solo-io/ && \
    git clone https://github.com/solo-io/packer-builder-arm-image && \
    cd packer-builder-arm-image && \
    dep ensure && \
    go build && \
    mkdir -p $HOME/.packer.d/plugins && \
    mv /go/src/github.com/solo-io/packer-builder-arm-image/packer-builder-arm-image $HOME/.packer.d/plugins/

# Setup the environment
COPY packer-wrapper.sh /packer-wrapper.sh
RUN chmod +x /packer-wrapper.sh && \
    mkdir /work
WORKDIR /work
VOLUME /work
ENTRYPOINT [ "/packer-wrapper.sh" ]
