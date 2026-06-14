#!/bin/bash

if [ "$1" == "up" ]; then
    nft add table ip filter
    nft 'add chain ip filter DOCKER-USER { type filter hook forward priority 0; }'
    nft insert rule ip filter DOCKER-USER iifname "wg0" accept
    nft insert rule ip filter DOCKER-USER oifname "wg0" accept

    nft add table ip nat
    nft 'add chain ip nat postrouting { type nat hook postrouting priority 100; }'
    nft add rule ip nat postrouting oifname "eth0" masquerade

elif [ "$1" == "down" ]; then
    nft flush chain ip filter DOCKER-USER 2>/dev/null
    nft delete rule ip nat postrouting handle \
        $(nft -a list chain ip nat postrouting 2>/dev/null | grep 'oifname "eth0" masquerade' | awk '{print $NF}') 2>/dev/null
fi
