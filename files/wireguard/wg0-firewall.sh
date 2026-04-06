#!/bin/bash

if [ "$1" == "up" ]; then
    nft delete table inet wireguard 2>/dev/null
    nft delete table ip nat 2>/dev/null

    nft add table inet wireguard
    nft add chain inet wireguard forward '{ type filter hook forward priority 0; policy accept; }'
    nft add rule inet wireguard forward iifname "wg0" accept
    nft add rule inet wireguard forward oifname "wg0" accept

    nft add table ip nat
    nft add chain ip nat postrouting '{ type nat hook postrouting priority 100; }'
    nft add rule ip nat postrouting oifname "eth0" masquerade

elif [ "$1" == "down" ]; then
    nft delete table inet wireguard 2>/dev/null
    nft delete table ip nat 2>/dev/null
fi
