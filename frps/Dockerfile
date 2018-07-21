FROM alpine:latest

LABEL maintainer="oldway <oldway2012@live.com>"

RUN apk upgrade --update \
    && apk add --no-cache --virtual .build-deps bash wget tar \
    && rm -rf /var/cache/apk/* ~/.cache

ARG frps_dir=/opt/frps
RUN mkdir -p ${frps_dir}
WORKDIR ${frps_dir}

# Install frp
RUN frp_ver="$(wget --no-check-certificate -qO- https://api.github.com/repos/fatedier/frp/releases/latest | grep 'tag_name' | cut -d\" -f4)" \
    && frp="frp_$(echo ${frp_ver} | sed -e 's/^[a-zA-Z]//g')_linux_amd64" \
    && frp_download_link="https://github.com/fatedier/frp/releases/download/${frp_ver}/${frp}.tar.gz" \
    && wget --no-check-certificate -q ${frp_download_link} -O ${frp}.tar.gz \
    && tar zxf ${frp}.tar.gz \
    && (cd ${frp} \
    # && cp -r frps* $frps_dir \
    && cp frps /usr/local/bin/ \
    && chmod + /usr/local/bin/frps) \
    && rm -rf ${frp} ${frp}.tar.gz 

COPY frps.ini-template ${frps_dir}

COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s /usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 80 443 7000 7500 6000

CMD ["frps","-c","/opt/frps/frps.ini"]