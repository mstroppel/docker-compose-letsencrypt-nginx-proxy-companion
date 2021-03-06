#!/bin/bash

# Set up your DOMAIN and NAME
if [ $# -lt 2 ]; then
    echo "Please pass your domain name and the docker container name as parameter to test your proxy."
    echo "./test_start_ssl.sh <domain name> <docker image name>"
    exit 1
else
    DOMAIN=$1
    NAME=$2
fi

# Read your .env file
source .env

# Testing your proxy
if [ -z ${SERVICE_NETWORK+X} ]; then
    docker run -d -e VIRTUAL_HOST=$DOMAIN -e LETSENCRYPT_HOST=$DOMAIN --network=$NETWORK --name $NAME httpd:alpine
else
    docker run -d -e VIRTUAL_HOST=$DOMAIN -e LETSENCRYPT_HOST=$DOMAIN --network=$SERVICE_NETWORK --name $NAME httpd:alpine
fi

exit 0
