#!/bin/bash

docker build -t buildenv buildenv-docker
docker run --rm buildenv > ./dockcross
chmod +x ./dockcross
