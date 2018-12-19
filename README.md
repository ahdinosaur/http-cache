# http-cache

**(not sure if this approach will be good enough for HTTPS, caveat emptor.)**

a Docker image to use [Nginx](https://nginx.org/en/) as an HTTP(S) proxy to cache static assets.

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

```
docker run -it --rm \
  -p 3142:3142 \
  -v "$(pwd)/cacher/log:/var/log/nginx" \
  -v "$(pwd)/cacher/data:/var/cache/nginx" \
  -v "$(pwd)/certs/server.cert:/app/server.cert" \
  -v "$(pwd)/certs/server.key:/app/server.key" \
  ahdinosaur/http-cache
```

notice you will need the volumes mounted to:

- `/var/log/nginx`: the nginx logs (`cache_access.log`)
- `/var/cache/nginx`: the nginx cache data
- `/app/server.cert`: if using https, your self-signed cert
- `/app/server.key`: if using https, your self-signed cert key

if using https, your self-signed cert **must** be trusted by the client using the proxy.

(TODO check this) to do this on Debian Linux:

- copy your self-signed cert files to `/etc/ssl/certs/`
- run `sudo update-ca-certificates`

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
