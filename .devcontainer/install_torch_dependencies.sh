#!/bin/bash

# Check if the path to the requirements file was provided
if [ -z "$1" ]; then
    echo "Please provide the path to the requirements file"
    exit 1
fi

# Set the path of the requirements.txt file
TORCH_REQUIREMENTS_FILE=$1

# Activate the virtual environment
source ./.venv/bin/activate

# Install the Python packages
pip install -r $TORCH_REQUIREMENTS_FILE -f https://download.pytorch.org/whl/torch_stable.html
