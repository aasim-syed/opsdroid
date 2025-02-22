FROM python:3.8-alpine
LABEL maintainer="Jacob Tomlinson <jacob@tomlinson.email>"

WORKDIR /usr/src/app
ARG EXTRAS=.[all,connector_matrix_e2e]

# Copy source
COPY . .

RUN apk update \
    && apk add --no-cache build-base linux-headers musl-dev python3-dev libzmq zeromq-dev git openssh-client olm olm-dev libffi-dev openssl-dev cargo \
    && pip3 install --upgrade pip \
    && pip3 install --no-cache-dir $EXTRAS \
    && apk del build-base linux-headers musl-dev python3-dev zeromq-dev

EXPOSE 8080

CMD ["opsdroid", "start"]
