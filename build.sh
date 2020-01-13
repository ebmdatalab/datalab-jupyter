#!/bin/bash

UBUNTU_VERSION=18.04
PYTHON_VERSION=3.8.1

docker build -t sebbacon/datalab-jupyter:python$PYTHON_VERSION --build-arg ubuntuversion=$UBUNTU_VERSION --build-arg pythonversion=$PYTHON_VERSION .
