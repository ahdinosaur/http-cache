#!/bin/bash

docker run -it --rm \
  -p 3142:3142 \
  -v "$(pwd)/cacher/log:/var/log/nginx" \
  -v "$(pwd)/cacher/data:/var/cache/nginx" \
  ahdinosaur/http-cache:"$(jq -r .version package.json)"
