FROM rust:alpine AS builder

RUN apk add --no-cache --update  musl-dev

WORKDIR /usr/src/app

COPY . .

ARG FOO
ARG BAR

ENV BAZ=$FOO:$BAR

RUN echo "BAZ!: $BAZ"

RUN cargo install --path .


FROM alpine

RUN apk add --no-cache --update tini

COPY --from=builder /usr/local/cargo/bin/rsenv /usr/local/bin/rsenv

ARG FOO
ARG BAR

ENV BAZ=$FOO:$BAR

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["rsenv"]
