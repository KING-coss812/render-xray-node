#!/bin/sh
PORT=${PORT:-8080}
UUID=${UUID:-e055b97f-1076-4578-bff4-50351cb1d234}
WS_PATH=${WS_PATH:-/ws-f88180fa}
cat > /app/config.json <<EOFCFG
{
"log": { "loglevel": "warning"},
"inbounds": [
{
"listen": "0.0.0.0",
"port": ${PORT},
"protocol": "vless",
"settings": {
"clients": [ { "id": "${UUID}", "flow": ""}],
"decryption": "none"
},
"streamSettings": {
"network": "ws",
"wsSettings": { "path": "${WS_PATH}"}
},
"sniffing": { "enabled": true, "destOverride": ["http", "tls"]}
}
],
"outbounds": [ { "protocol": "freedom"}]
}
EOFCFG
exec /app/xray run -c /app/config.json
