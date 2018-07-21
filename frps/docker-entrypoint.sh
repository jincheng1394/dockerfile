#!/bin/bash
set -e
FRPS_DASHBOARD_USER=${FRPS_DASHBOARD_USER:-admin}               # dashboard_user = admin
FRPS_DASHBOARD_PWD=${FRPS_DASHBOARD_PWD:-admin}                 # dashboard_pwd = admin
FRPS_PRIVILEGE_TOKEN=${FRPS_PRIVILEGE_TOKEN:-password}          # privilege_token = password
FRPS_MAX_POOKL_COUNT=${FRPS_MAX_POOKL_COUNT:-50}                # max_pool_count = 50
FRPS_LOG_LEVEL==${FRPS_LOG_LEVEL:-info}                         # log_level = info
FRPS_LOG_MAX_DAYS=${FRPS_LOG_MAX_DAYS:-3}                       # log_max_days = 3
FRPS_SUBDOMIN_HOST=${FRPS_SUBDOMIN_HOST:-aiiway.com}            # subdomain_host = aiiway.com

while getopts "u:p:h" OPT; do
    case $OPT in
        u)
            FRPS_DASHBOARD_USER=$OPTARG;;
        p)
            FRPS_DASHBOARD_PWD=$OPTARG;;
        h)
            FRPS_SUBDOMIN_HOST=$OPTARG;;
    esac
done

[ -f frps.ini-template ] && cat frps.ini-template | awk '$0 !~ /^\s*#.*$/' | sed 's/[ "]/\\&/g' |
    while read -r line;do 
        eval echo ${line}
    done >frps.ini

exec "$@"