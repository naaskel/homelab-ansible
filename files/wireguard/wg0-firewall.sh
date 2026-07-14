#!/bin/bash

if [ "$1" == "up" ]; then
    nft insert rule ip filter FORWARD iifname "wg0" accept
    nft insert rule ip filter FORWARD oifname "wg0" accept

    nft add table ip nat
    nft 'add chain ip nat postrouting { type nat hook postrouting priority 100; }'
    nft add rule ip nat postrouting oifname "eth0" masquerade

elif [ "$1" == "down" ]; then
    for h in $(nft -a list chain ip filter FORWARD 2>/dev/null | grep '"wg0" accept' | awk '{print $NF}'); do
        nft delete rule ip filter FORWARD handle "$h" 2>/dev/null
    done
    nft delete rule ip nat postrouting handle \
        $(nft -a list chain ip nat postrouting 2>/dev/null | grep 'oifname "eth0" masquerade' | awk '{print $NF}') 2>/dev/null
fi
