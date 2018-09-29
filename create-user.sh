#!/bin/sh

[ -z "$1" ] && exit 1
cd $(dirname "$0")/../easy-rsa
./easyrsa build-client-full client-$1 nopass

