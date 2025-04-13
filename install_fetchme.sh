#!/bin/bash

set -e  # Exit on error

if [[ -f ./fetchme ]]; then
    sudo mv ./fetchme /usr/local/bin/fetchme
fi
sudo chmod +x /usr/local/bin/fetchme



