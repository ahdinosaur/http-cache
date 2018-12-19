FROM debian:stretch-slim
MAINTAINER Michael Williams <michael.williams@enspiral.com>

WORKDIR /app

RUN \ 
  echo "deb-src http://deb.debian.org/debian stretch main" | tee -a /etc/apt/sources.list && \
  echo "deb-src http://security.debian.org/debian-security stretch/updates main" | tee -a /etc/apt/sources.list && \
  echo "deb-src http://deb.debian.org/debian stretch-updates main" | tee -a /etc/apt/sources.list && \
  apt-get update -y && \
  apt-get install -y --no-install-recommends \
    git devscripts equivs ca-certificates nginx-light && \
  mk-build-deps nginx --install --remove --tool "apt-get -y --no-install-recommends" && \
  cd /app && \
    apt-get source nginx && \
    git clone https://github.com/chobits/ngx_http_proxy_connect_module && \
    cd nginx-* && \
      patch -p1 < ../ngx_http_proxy_connect_module/patch/proxy_connect.patch && \
      ./configure --add-module=/app/ngx_http_proxy_connect_module && \
      make && \
      make install && \
      cd .. && \
    cd .. && \
  apt-get remove -y \
    git devscripts nginx-build-deps && \
  apt-get clean -y && \
  apt-get autoremove -y && \
  rm -rf /var/lib/apt/lists/*

ADD nginx.conf /usr/local/nginx/conf/nginx.conf

EXPOSE 3412

CMD /usr/local/nginx/sbin/nginx
