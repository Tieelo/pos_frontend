FROM nginx:alpine

USER root

RUN apk upgrade --no-cache &&\
    apk add --no-cache bash curl

ARG VITE_BACKEND_URL
ENV VITE_BACKEND_URL=$VITE_BACKEND_URL

COPY /dist/ /usr/share/nginx/html/