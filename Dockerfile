FROM alpine

LABEL MAINTAINER="<crazyjums@gmail.com>"

ADD nginx-1.18.0.tar.gz /tmp
ADD nginx/nginx.conf /tmp/nginx.conf
ADD start.sh /tmp/start.sh
ADD nginx/include/default.conf /tmp/default.conf

## isntall nginx by source code
WORKDIR /tmp/nginx-1.18.0

RUN apk update && apk upgrade\
	&& apk add --no-cache --virtual .build-deps \
	mlocate \
	g++ \
	pcre-dev \
	zlib-dev \
	make\
	gcc\
	libc-dev\
	libxml2-dev\
	&& apk add pcre\
	&& apk add sqlite-dev \
	&& addgroup -S nginx\
	&& adduser -S -G nginx -s /sbin/nologin -h /usr/local/nginx nginx\
	&& ./configure --user=nginx --group=nginx --prefix=/usr/local/nginx\
	&& make\
	&& make install\
	&& mkdir -p /data/nginx/logs /data/nginx/logs\
    && mkdir -p /usr/local/nginx/conf/include \
	&& mv /usr/local/nginx/conf/nginx.conf /usr/local/nginx/conf/nginx.conf.back\
	&& mv /tmp/nginx.conf /usr/local/nginx/conf/nginx.conf\
	&& mv /tmp/start.sh /start.sh\
    && mv /tmp/default.conf /usr/local/nginx/conf/include/default.conf \
	&& rm -rf /tmp/*\
	&& ln -s /usr/local/nginx/sbin/nginx /usr/local/bin/ \
	&& /usr/local/nginx/sbin/nginx -t \
    && apk del .build-deps

EXPOSE 80

ENTRYPOINT ["/bin/sh","/start.sh"]