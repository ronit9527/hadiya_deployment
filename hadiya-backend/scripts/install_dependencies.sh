#!/bin/bash

if [ ! -d /home/ubuntu/hadiya/products ]; then
    echo "Project directory doesn't exists. Exiting with code 1 ...";
    exit 1;
fi
cd /home/ubuntu/hadiya/products
echo "Installing dependencies ..."
npm install --omit=dev
echo "Installation complete!"