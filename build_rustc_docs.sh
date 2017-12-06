#!/bin/bash

set -x
set -v

cd /tmp
git clone https://github.com/rust-lang/rust.git
cd /tmp/rust
cp config.toml.example config.toml
sed -e 's/#compiler-docs = false/compiler-docs = true/g' -i config.toml
/usr/bin/python2.7 x.py doc
rm -rf /data/docs
mkdir /data/docs
cp -r \
    build/x86_64-unknown-linux-gnu/doc/ \
    build/x86_64-unknown-linux-gnu/md-doc/ \
    build/x86_64-unknown-linux-gnu/crate-docs/ \
    /data/docs
