FROM nginx:alpine

USER root

RUN apk upgrade --no-cache &&\
    apk add --no-cache bash curl

COPY /dist/ /usr/share/nginx/html/
COPY /scripts/40-change-backend-address.sh /docker-entrypoint.d/40-change-backend-address.sh