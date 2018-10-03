FROM golang:latest as runner
RUN go get github.com/spiral/roadrunner/...
RUN cd /go/src/github.com/spiral/roadrunner/ && make

FROM composer:latest as composer
FROM php:latest as php
WORKDIR /app
RUN apt-get update
RUN apt-get install -y git zip unzip
COPY ./ /app
COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN composer install
COPY --from=runner /go/src/github.com/spiral/roadrunner/rr /app/rr
RUN chmod +x /app/rr
ENTRYPOINT /app/rr serve
