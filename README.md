# http-cache

a Docker image to use [Nginx](https://nginx.org/en/) as an HTTP(S) proxy to cache static assets.

**caveat emptor: can only do insecure HTTPS proxying**

helpful when you need to repeatedly install packages from `apt-get`, `npm`, `cargo`, etc.

inspiration from:

- [`pmendelski/nginx-cache`](https://github.com/pmendelski/docker-images/tree/master/nginx-cache)
- [`reiz/nginx-proxy`](https://github.com/reiz/nginx_proxy)
- [`chobits/ngx_http_proxy_connect_module#28`](https://github.com/chobits/ngx_http_proxy_connect_module/issues/28)

## usage

first, download the [Docker image](https://hub.docker.com/r/ahdinosaur/http-cache):

```shell
docker pull ahdinosaur/http-cache
```

then run it as:

```shell
docker run -it --rm \
  -p 3142:3142 \
  -v "$(pwd)/cacher/log:/var/log/nginx" \
  -v "$(pwd)/cacher/data:/var/cache/nginx" \
  ahdinosaur/http-cache
```

notice you will need the volumes mounted to:

- `/var/log/nginx`: the nginx logs (`cache_access.log`)
- `/var/cache/nginx`: the nginx cache data

to test it works:

```shell
curl -I --proxy 'http://localhost:3142' 'https://cdnjs.cloudflare.com/ajax/libs/react/15.3.1/react.min.js'
```

## license

The Apache License

Copyright &copy; 2018 Michael Williams

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
