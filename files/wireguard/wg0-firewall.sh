#!/bin/bash

if [ "$1" == "up" ]; then
    nft add chain ip filter DOCKER-USER
    nft insert rule ip filter DOCKER-USER iifname "wg0" accept
    nft insert rule ip filter DOCKER-USER oifname "wg0" accept
    nft add rule ip nat postrouting oifname "eth0" masquerade

elif [ "$1" == "down" ]; then
    nft flush chain ip filter DOCKER-USER
    nft delete rule ip nat postrouting handle \
        $(nft -a list chain ip nat postrouting | grep 'oifname "eth0" masquerade' | awk '{print $NF}') 2>/dev/null
fi
