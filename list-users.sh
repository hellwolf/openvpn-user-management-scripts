#!/bin/sh

cd $(dirname "$0")/../easy-rsa
{
    (cd pki/issued;ls client-* 2>/dev/null | sed -n 's/^client-\(.*\).crt$/\1/p')
    (cd pki/private;ls client-* 2>/dev/null | sed -n 's/^client-\(.*\).key$/\1/p')
    (cd pki/reqs;ls client-* 2>/dev/null | sed -n 's/^client-\(.*\).req$/\1/p')
} | sort | uniq
