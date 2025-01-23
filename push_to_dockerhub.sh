#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

docker login
if [ $? -ne 0 ]; then
    echo "Error: Docker login failed"
    exit 1
fi

SERVICES_DIR=($(ls $SCRIPT_DIR/services | grep '-service'))

for service in "${SERVICES_DIR[@]}"; do 
    cd $SCRIPT_DIR/services/$service
    docker build -t flexdogg/$service:latest .
    docker push flexdogg/$service:latest
done
