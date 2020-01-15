This is a Docker base image for use in our jupyter analytics work.

We use Docker to ensure we have a unified developer environment
between Windows, OSX and Linux.  Windows, in particular, ends up being
hard for our engineering team to support as package support tends to
be split between `pip` and `conda`.

It includes:

* Python installed with pyenv
* Jupyter and Jupyter Lab
* Jupytext for better diffing / code review workflows
* A Jupyter kernel for bash, to help debug environment issues through
  the browser


# Continuous integration

Images that use this as the base should reference it by tag, so the
correct version of Python is used. For example:


    FROM ebmdatalab/datalab-jupyter:python3.8.1

When upgrading python here, also update the corresponding `FROM` in
https://github.com/ebmdatalab/custom-docker/; the same applies to
upgrading packages in `requirements.txt` and/or adding packages to
`requirements.in`.

Builds of different pythons are handled by Docker Hub's build service,
which [provides custom build
hooks](https://docs.docker.com/docker-hub/builds/advanced/) (see the content of `hooks/`).

Our hooks build one Ubuntu version and one or more Python versions as
specified in the `BUILD_VERSIONS` file.

When finalising a notebook for publication, a docker tag including a
git commit should be used to pin it, e.g. `ebmdatalab/datalab-jupyter:python3.8.1-85de6835b227bb854e8e718ffed5002d40a1218c`

To build locally using the same hooks as Docker Hub, run `./build.sh`.
