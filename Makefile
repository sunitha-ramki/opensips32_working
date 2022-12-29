NAME ?= opensipsramki
OPENSIPS_VERSION ?= 3.3
OPENSIPS_BUILD ?= releases
OPENSIPS_DOCKER_TAG ?= latest
OPENSIPS_CLI ?= true

all: build start

.PHONY: build start
build:
	docker build \
		--build-arg=OPENSIPS_BUILD=$(OPENSIPS_BUILD) \
		--build-arg=OPENSIPS_VERSION=$(OPENSIPS_VERSION) \
		--tag="opensips/opensips:$(OPENSIPS_DOCKER_TAG)" \
		.

start:
	docker run --name opensipsramki -p 192.168.0.103:6060:5060 -d opensips/opensips:latest
