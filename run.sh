#!/usr/bin/env bash

mkdir -p user-data data

cp $HOME/.netrc user-data/netrc
cp $HOME/.cache/huggingface/token user-data/huggingface-token

docker build -t ablateit .
docker run --rm -it -v $(pwd)/data:/data --gpus=all ablateit
