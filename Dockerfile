FROM ubuntu:17.10
MAINTAINER Vytautas Astrauskas "vastrauskas@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

# Install prerequisites.
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        locales \
        curl \
        wget \
        && \
    apt-get clean

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

# Install Rust.
RUN mkdir -p /tmp/rust && \
    cd /tmp/rust && \
    wget -q -c https://sh.rustup.rs -O install.sh && \
    chmod 755 install.sh && \
    ./install.sh -y --no-modify-path --default-toolchain nightly-2017-11-15 && \
    rm -rf /tmp/rust

# Install additional dependencies.
RUN cargo install mdbook --vers "0.0.26"

# Set up locale.
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Mark container.
ENV RUST_CONTAINER 1

# Set the working directory.
WORKDIR /data
