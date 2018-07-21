#! /bin/bash

./build.sh

docker run -it --rm oldway/frpc /bin/sh