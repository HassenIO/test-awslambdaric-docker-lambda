THIS_FILE := $(lastword $(MAKEFILE_LIST))
TAG := 0.1.0

build:
	docker build -t local-lambda-test:$(TAG) .

build-debug:
	DOCKER_BUILDKIT=0 $(MAKE) -f $(THIS_FILE) build

run:
	docker run --rm -p 5050:8080 --name local-lambda-test local-lambda-test:$(TAG)

test:
	curl -XPOST "http://localhost:5050/2015-03-31/functions/function/invocations" -d '$(data)' | jq