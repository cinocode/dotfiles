#!/bin/bash
mkdir -p ~/.cache/tidepool-cli
tp_cache=~/.cache/tidepool-cli/waybar

tidepool-cli > $tp_cache

bg_val=$(cat $tp_cache | head -n 1 | tail -1 | cut -d ' ' -f 2)
bg_class=$(cat $tp_cache | head -n 3 | tail -1 | cut -d ' ' -f 2)

case $(cat $tp_cache | head -n 2 | tail -1 | cut -b 8-) in
"dropping fast")
    state="🡓"
    ;;
"dropping slow")
    state="🡖"
    ;;
"rising fast")
    state="🡑"
    ;;
"rising slow")
    state="🡕"
    ;;
*)
    state="🡒"
    ;;
esac

echo "{\"text\":\"$bg_val $state\", \"class\":\"$bg_class\"}"
