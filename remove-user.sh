#!/bin/sh

[ -z "$1" ] && exit 1
cd $(dirname "$0")/../easy-rsa
rm -f pki/issued/client-$1.crt
rm -f pki/private/client-$1.key
rm -f pki/reqs/client-$1.req
