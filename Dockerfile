ARG ubuntuversion
FROM ubuntu:$ubuntuversion
ARG pythonversion

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
ENV UBUNTU_VERSION $ubuntuversion
RUN apt-get update && apt-get -y upgrade \

# Python dependencies
    && apt-get install -y --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
# Pyenv dependencies
    ca-certificates git \
# Useful for nbconvert
    pandoc texlive-xetex bash \
# Required to build extensions for jupyter
    && apt install -y nodejs npm \
# Required to build geopandas
    libgeos-dev \
# Allows us to use add-apt-repository (below)
    software-properties-common

# R 3.6 per https://cran.r-project.org/bin/linux/ubuntu/README.html
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 \
    && add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release --codename --short)-cran35/" \
    && apt update \
    && apt install -y r-base-dev

# Install pyenv
RUN curl https://pyenv.run | bash
ENV PATH="/root/.pyenv/shims:/root/.pyenv/bin:${PATH}"
ENV PYENV_SHELL=bash

# Install python
RUN pyenv install $pythonversion \
    && pyenv global $pythonversion

# Install pip and requirements
RUN curl https://bootstrap.pypa.io/get-pip.py | python
COPY requirements.txt /tmp/
RUN pip install --requirement /tmp/requirements.txt

# Instructions from https://plot.ly/python/getting-started/
# Jupyter widgets extension
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager@1.1 --no-build \

# jupyterlab renderer support
    && jupyter labextension install jupyterlab-plotly@1.4.0 --no-build \

# FigureWidget support
    && jupyter labextension install plotlywidget@1.4.0 --no-build \

# Build extensions
    && jupyter lab build \

# Useful for debugging
    && python -m bash_kernel.install
