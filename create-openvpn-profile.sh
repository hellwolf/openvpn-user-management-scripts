#!/bin/sh

[ -z "$1" ] && exit 1
cd $(dirname "$0")/../easy-rsa

PORT=$(grep '^port' ../server.conf  | awk '{print $2}')
PROTO=$(grep '^proto' ../server.conf  | awk '{print $2}')

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
`cat pki/ca.crt`
</ca>

<cert> 
`cat pki/issued/client-$1.crt`
</cert>

<key>
`cat pki/private/client-$1.key`
</key>

<tls-auth>
`cat ../ta.key`
</tls-auth>
key-direction 1
EOF
