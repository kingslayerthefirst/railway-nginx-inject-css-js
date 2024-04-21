FROM nginx:alpine AS runtime

RUN apk add --no-cache bash

ARG SERVER_NAME=_
ARG PROXY_PASS=http://host.docker.internal:3000
ARG PORT=4000
ARG INJECT_CSS=https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css
ARG INJECT_JS=https://code.jquery.com/jquery-3.7.1.min.js
ARG FIND_TITLE_VALUE=Hello World
ARG REPLACE_TITLE_WITH_VALUE=I am a new title

RUN echo "server_name: $SERVER_NAME\nproxy_pass: $PROXY_PASS\nport: $PORT\ninject_css: $INJECT_CSS\ninject_js: $INJECT_JS"

COPY ./configure_nginx.sh /etc/nginx/configure_nginx.sh
RUN chmod +x /etc/nginx/configure_nginx.sh
RUN /etc/nginx/configure_nginx.sh

EXPOSE ${PORT}