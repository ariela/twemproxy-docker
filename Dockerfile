#===+====1====+=====2====+=====3====+=====4====+=====5====+=====6====+=====7====+=====8====+=====9====+=====0
# ビルドステージ
#===+====1====+=====2====+=====3====+=====4====+=====5====+=====6====+=====7====+=====8====+=====9====+=====0
FROM debian:bullseye-slim AS build-stage

RUN apt-get update && apt-get install -y curl automake libtool make

ARG TWEMPROXY_VERSION=0.5.0
RUN curl -LO https://github.com/twitter/twemproxy/releases/download/${TWEMPROXY_VERSION}/twemproxy-${TWEMPROXY_VERSION}.tar.gz && \
    tar zxf twemproxy-${TWEMPROXY_VERSION}.tar.gz && \
    mv -f twemproxy-${TWEMPROXY_VERSION} twemproxy && \
    cd twemproxy && \
    autoreconf -fvi && \
    ./configure --enable-debug=full --prefix=/usr/local/twemproxy && \
    make && \
    make install

#===+====1====+=====2====+=====3====+=====4====+=====5====+=====6====+=====7====+=====8====+=====9====+=====0
# 公開用イメージ
#===+====1====+=====2====+=====3====+=====4====+=====5====+=====6====+=====7====+=====8====+=====9====+=====0
FROM debian:bullseye-slim

COPY --from=build-stage /usr/local/twemproxy /usr/local/twemproxy
COPY --from=build-stage /twemproxy/conf/nutcracker.yml /usr/local/twemproxy/etc/nutcracker.yml
ENV PATH $PATH:/usr/local/twemproxy/sbin:/usr/local/twemproxy/bin

CMD [ "nutcracker", "-v6", "-c" ,"/usr/local/twemproxy/etc/nutcracker.yml" ]
