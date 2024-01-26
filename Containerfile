FROM debian:sid
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt upgrade -y
RUN apt update && apt install -y gcc gcc-aarch64-linux-gnu
RUN apt install -y bc bison build-essential coccinelle \
  device-tree-compiler dfu-util efitools flex gdisk graphviz imagemagick \
  liblz4-tool libgnutls28-dev libguestfs-tools libncurses-dev \
  libpython3-dev libsdl2-dev libssl-dev lz4 lzma lzma-alone openssl \
  pkg-config python3 python3-asteval python3-coverage python3-filelock \
  python3-pkg-resources python3-pycryptodome python3-pyelftools \
  python3-pytest python3-pytest-xdist python3-sphinxcontrib.apidoc \
  python3-sphinx-rtd-theme python3-subunit python3-testtools \
  python3-virtualenv swig uuid-dev
RUN apt install -y screen bc bison flex libssl-dev make python3-dev python3-pyelftools python3-setuptools swig git

COPY patches/ /build/patches/
COPY rkbin/ /build/rkbin/
COPY Makefile /build/

RUN git config --global user.email "blah@blah.com"
ENV CROSS_COMPILE=aarch64-linux-gnu-
# https://docs.u-boot.org/en/latest/build/reproducible.html
ARG SOURCE_DATE_EPOCH=1704728268
WORKDIR /build
RUN make target_odroid-m1
