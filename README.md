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
