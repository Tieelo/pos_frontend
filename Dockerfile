FROM nginx:alpine

USER root

RUN apk upgrade --no-cache &&\
    apk add --no-cache bash curl

COPY /dist/ /usr/share/nginx/html/pos/