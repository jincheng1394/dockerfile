FROM alpine:latest

LABEL maintainer="oldway <oldway2012@live.com>"

RUN apk upgrade --update \
    && apk add --no-cache --virtual .build-deps bash wget tar \
    && rm -rf /var/cache/apk/* ~/.cache

ARG frpc_dir=/opt/frpc
RUN mkdir -p ${frpc_dir}
WORKDIR ${frpc_dir}

# Install frp
RUN frp_ver="$(wget --no-check-certificate -qO- https://api.github.com/repos/fatedier/frp/releases/latest | grep 'tag_name' | cut -d\" -f4)" \
    && frp="frp_$(echo ${frp_ver} | sed -e 's/^[a-zA-Z]//g')_linux_amd64" \
    && frp_download_link="https://github.com/fatedier/frp/releases/download/${frp_ver}/${frp}.tar.gz" \
    && wget --no-check-certificate -q ${frp_download_link} -O ${frp}.tar.gz \
    && tar zxf ${frp}.tar.gz \
    && (cd ${frp} \
    && cp -r frpc*.ini $frpc_dir \
    && cp frpc /usr/local/bin/ \
    && chmod + /usr/local/bin/frpc) \
    && rm -rf ${frp} ${frp}.tar.gz 

CMD ["frpc","-c","/opt/frpc/frpc.ini"]