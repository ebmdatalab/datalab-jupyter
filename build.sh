#!/bin/bash

# This file mimics the environment provided by Docker Hub's build
# service, so you can test builds locally

DOCKER_REPO=ebmdatalab/datalab-jupyter DOCKERFILE_PATH=Dockerfile SOURCE_COMMIT=$(git rev-parse HEAD) hooks/build
