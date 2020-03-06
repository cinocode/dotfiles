#!/bin/sh
ping_result=$(~/.bin/lht_ping)

if [[ $ping_result = 0 ]]; then
    echo -e "{\"text\":\"-\", \"class\":\"red\"}"
elif [[ $ping_result = 1 ]]; then
    echo -e "{\"text\":\"\", \"class\":\"\"}"
elif [[ $ping_result = 2 ]]; then
    echo -e "{\"text\":\"LHT\", \"class\":\"\"}"
elif [[ $ping_result = 3 ]]; then
    echo -e "{\"text\":\"LHT\", \"class\":\"red\"}"
fi
