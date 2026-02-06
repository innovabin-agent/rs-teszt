FROM rust:alpine AS builder

RUN apk add --no-cache --update  musl-dev

WORKDIR /usr/src/app

COPY . .

ARG BAZ

RUN cargo install --path .


FROM alpine

RUN apk add --no-cache --update tini

COPY --from=builder /usr/local/cargo/bin/rsenv /usr/local/bin/rsenv

ARG BAZ


ENTRYPOINT ["/sbin/tini", "--"]

CMD ["rsenv"]
