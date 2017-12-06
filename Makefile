SHELL := /bin/bash
IMAGE_VERSION=2017-12-06
IMAGE_NAME="vakaras/rust:${IMAGE_VERSION}"

build_image:
	sudo docker build -t ${IMAGE_NAME} .

shell: | workspace
	sudo docker run --rm -ti \
		-v "${CURDIR}/workspace:/data" \
		${IMAGE_NAME} /bin/bash

workspace:
	mkdir -p workspace

workspace/build_rustc_docs.sh: workspace build_rustc_docs.sh
	cp build_rustc_docs.sh workspace/build_rustc_docs.sh
	chmod 755 workspace/build_rustc_docs.sh

build_rustc_docs: workspace/build_rustc_docs.sh
	sudo docker run --rm -ti \
		-v "${CURDIR}/workspace:/data" \
		${IMAGE_NAME} /data/build_rustc_docs.sh
