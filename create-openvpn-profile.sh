#!/bin/sh

[ -z "$1" ] && exit 1
cd $(dirname "$0")/../easy-rsa

cat <<EOF
remote ec2-dev2.mzcholdings.com 20965 udp
nobind
dev tun
persist-tun 
persist-key 
compress 
pull 
tls-client 

<ca> 
`cat ../ca.crt`
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
