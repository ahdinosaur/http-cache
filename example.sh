#!/bin/bash

docker run -it --rm \
  -p 3142:3142 \
  -v "$(pwd)/cacher/log:/var/log/nginx" \
  -v "$(pwd)/cacher/data:/var/cache/nginx" \
  -v "$(pwd)/certs/server.cert:/app/server.cert" \
  -v "$(pwd)/certs/server.key:/app/server.key" \
  ahdinosaur/http-cache:"$(jq -r .version package.json)"
