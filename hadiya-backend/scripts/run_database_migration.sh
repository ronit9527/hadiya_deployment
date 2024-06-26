#!/bin/bash

PROJECT_HOME=/home/ubuntu/hadiya/products
ERROR_LOGS_PATH=/home/ubuntu/hadiya/logs/products

if [ ! -d $PROJECT_HOME ]; then
    echo "Project directory doesn't exists. Exiting with code 1 ...";
    exit 1;
fi
if [ ! -d $ERROR_LOGS_PATH ]; then
    echo "Creating logs directory...";
    mkdir -p $ERROR_LOGS_PATH;
fi
cd /home/ubuntu/hadiya/products
echo "Migrating database ..."
sequelize db:migrate 2> $ERROR_LOGS_PATH/error-$(date +%F).log
if [ $? -ne 0 ]; then
    echo "Error occured. Please theck the logs at ${ERROR_LOGS_PATH}/error-$(date +%F).log";
    exit 1;
fi
echo "Migrated database successfully"