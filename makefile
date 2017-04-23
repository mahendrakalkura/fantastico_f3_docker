MAKEFLAGS+=--ignore-errors
MAKEFLAGS+=--no-print-directory
SHELL:=/bin/bash

.PHONY: reset
.PHONY: clean
.PHONY: build
.PHONY: run

reset:
	docker rm --force $$(docker ps --all --quiet)
	docker ps --all
	docker rmi --force $$(docker images --all --quiet)
	docker images --all

clean:
	docker container prune --force
	docker image prune --force
	docker system prune --force

build:
	docker build --tag netenberg/fantastico_f3 .

run:
	docker run \
		--attach stdin \
		--attach stdout \
		--interactive \
		--tty \
		--volume ${FANTASTICO_F3_CORE}:/var/netenberg/fantastico_f3/sources \
		--volume mysql:/var/lib/mysql \
		netenberg/fantastico_f3
