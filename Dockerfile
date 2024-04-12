FROM nginx:alpine

USER root

RUN apk upgrade --no-cache &&\
    apk add --no-cache bash curl

COPY /dist/ /usr/share/nginx/html/
ENV API_BASE_URL=http://172.17.0.3:11386