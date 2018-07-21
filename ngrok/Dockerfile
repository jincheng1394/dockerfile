FROM alpine:3.7

LABEL maintainer="oldway <oldway2012@live.com>"


# 安装常用组件
RUN apk upgrade --update \
    && apk add bash tzdata \
    && apk add --virtual .build-deps wget \
    && rm -rf /var/cache/apk/*

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo Asia/Shanghai > /etc/timezone

WORKDIR /opt

RUN wget --no-check-certificate https://raw.githubusercontent.com/clangcn/ngrok-one-key-install/master/latest/client_ngrok_linux_amd64 -O /usr/bin/ngrok

RUN ["chmod", "755", "/usr/bin/ngrok"]

CMD ["ngrok"]