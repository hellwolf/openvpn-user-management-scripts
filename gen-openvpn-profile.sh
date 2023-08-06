#!/usr/bin/env bash

oops () {
    echo "$@" >&2
    exit 1
}

[ -z "$1" ] && oops "user name not provided"
cd $(dirname "$0")/../easy-rsa

PORT=$(grep '^port' ../server.conf  | awk '{print $2}')
PROTO=$(grep '^proto' ../server.conf  | awk '{print $2}')
SERVER_CA_CERT_FILE=pki/ca.crt
CLIENT_CERT_FILE=pki/issued/client-$1.crt
CLIENT_KEY_FILE=pki/private/client-$1.key

[ -f "$CLIENT_CERT_FILE" ] || oops client cert file not found: "$CLIENT_CERT_FILE"
[ -f "${CLIENT_CERT_FILE}" ] || oops client key file not found: "$CLIENT_KEY_FILE"

cat <<EOF
remote `hostname` $PORT $PROTO
nobind
dev tun
persist-tun
persist-key
compress
pull
tls-client

<ca>
$(cat "${SERVER_CA_CERT_FILE}")
</ca>

<cert>
$(cat "${CLIENT_CERT_FILE}")
</cert>

<key>
$(cat "${CLIENT_KEY_FILE}")
</key>

<tls-auth>
`cat ../ta.key`
</tls-auth>
key-direction 1
EOF
