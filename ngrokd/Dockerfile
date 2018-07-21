FROM golang:alpine3.7

LABEL maintainer="oldway <oldway2012@live.com>"

ENV NGROKD_DOMAIN="xxxx.com"
ENV NGROKD_PASSWORD=""

# 安装常用组件
RUN apk upgrade --update \
    && apk add bash tzdata \
    && apk add --virtual .build-deps wget ca-certificates openssl \
    && rm -rf /var/cache/apk/*

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo Asia/Shanghai > /etc/timezone

WORKDIR /opt

RUN wget --no-check-certificate https://raw.githubusercontent.com/clangcn/ngrok-one-key-install/master/latest/server_ngrokd_linux_amd64 -O /usr/bin/ngrokd

EXPOSE 80
EXPOSE 443
EXPOSE 4443

RUN ["chmod", "755", "/usr/bin/ngrokd"]

# 生成证书
RUN openssl genrsa -out rootCA.key 2048 \
    && openssl req -x509 -new -nodes -key rootCA.key -subj "/CN=$NGROKD_DOMAIN" -days 5000 -out rootCA.pem \
    && openssl genrsa -out server.key 2048 \
    && openssl req -new -key server.key -subj "/CN=$NGROKD_DOMAIN" -out server.csr \
    && openssl x509 -req -in server.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out server.crt -days 5000

CMD ngrokd -domain="$NGROKD_DOMAIN" -httpAddr=":80" -httpsAddr=":432" -pass="$NGROKD_PASSWORD" -tlsCrt="server.crt" -tlsKey="server.key" -tunnelAddr=":4443"