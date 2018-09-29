#!/bin/sh

cd $(dirname "$0")/../easy-rsa
{
    (cd pki/issued;ls client-* | sed -n 's/^client-\(.*\).crt$/\1/p')
    (cd pki/private;ls client-* | sed -n 's/^client-\(.*\).key$/\1/p')
    (cd pki/reqs;ls client-* | sed -n 's/^client-\(.*\).req$/\1/p')
} | sort | uniq
