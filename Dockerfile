# Use an official Python runtime as a parent image.
# See https://hub.docker.com/_/python for more information.
# To understand docker image tags, see https://forums.docker.com/t/differences-between-standard-docker-images-and-alpine-slim-versions/134973
FROM python:3.7-slim-bullseye

# Install system packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    # deps for downloading models
    curl \
    # deps for development
    git \
    openssh-client \
    # deps for python packages
    build-essential \
    python3-dev \
    libffi-dev \
    g++ \
    libblas-dev \
    liblapack-dev \
    gfortran \
    libblas3 \
    liblapack3 \
    libatlas-base-dev \
    libx11-dev \
    x11-xserver-utils \
    && apt-get clean

# Set the working directory to /opt/app
WORKDIR /opt/app

# Upgrade pip
RUN pip install --upgrade pip

# Copy the requirements file
COPY requirements.txt torch-requirements.txt ./

# Install dependencies from the requirements file
RUN pip install -r requirements.txt \ 
    && pip install -r torch-requirements.txt -f https://download.pytorch.org/whl/torch_stable.html

# Copy Code
ADD KUKA-experiment ./KUKA-experiment
ADD MBD_simulator ./MBD_simulator
ADD MBD_simulator_torch ./MBD_simulator_torch
ADD sgp ./sgp
ADD utils ./utils
COPY .directory .

# Keep container idle
CMD tail -f /dev/null
