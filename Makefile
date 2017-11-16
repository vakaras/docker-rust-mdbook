SHELL := /bin/bash
IMAGE_VERSION=2017-11-15
IMAGE_NAME="vakaras/rust:${IMAGE_VERSION}"

build_image:
	sudo docker build -t ${IMAGE_NAME} .

shell: | workspace
	sudo docker run --rm -ti \
		-v "${CURDIR}/workspace:/data" \
		${IMAGE_NAME} /bin/bash

workspace:
	mkdir -p workspace
