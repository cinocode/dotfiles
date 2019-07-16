#!/bin/bash
sudo ln -sf /home/ole/.config/squid/squid_default /usr/local/bin/squid_default
sudo ln -sf /home/ole/.config/squid/squid_lht /usr/local/bin/squid_lht

echo use .config/squid/squid_manage as an example
echo copy it to /etc/NetworkManager/dispatcher.d/
echo find out the network uuids from /etc/NetworkManager/system-connections
echo chmod it to 700 and make sure it belongs to root
