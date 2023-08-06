#!/usr/bin/env sh

cd $(dirname "$0")/../easy-rsa

rm -f pki/reqs/server.req pki/issued/server.crt pki/private/server.key

./easyrsa build-server-full server nopass
