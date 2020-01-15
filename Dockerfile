ARG ubuntuversion
FROM ubuntu:$ubuntuversion
ARG pythonversion

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN apt-get update
RUN apt-get -y upgrade
# Python dependencies
RUN apt-get install -y --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
# Pyenv dependencies
RUN apt-get install -y ca-certificates git
# Useful for nbconvert
RUN apt-get install -y pandoc texlive-xetex bash
# Required to build extensions for jupyter
RUN apt-get install -y nodejs
# Required to build geopandas
RUN apt-get install -y libgeos-dev

RUN useradd -m app
USER app

# Install pyenv
RUN curl https://pyenv.run | bash
ENV PATH="/home/app/.pyenv/shims:/home/app/.pyenv/bin:${PATH}"
ENV PYENV_SHELL=bash

# Install python
RUN ls -l /home/app/.pyenv/bin
RUN pyenv install $pythonversion
RUN pyenv global $pythonversion

# Install pip
RUN curl https://bootstrap.pypa.io/get-pip.py | python

COPY requirements.txt /tmp/
RUN pip install --requirement /tmp/requirements.txt

# Required to build jupytext extension
RUN jupyter lab build

# Useful for debugging
RUN python -m bash_kernel.install
