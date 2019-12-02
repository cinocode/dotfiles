#!/bin/bash
if pgrep -x swaylock; then
    if [[ -z $(pgrep -x VirtualBoxVM) ]]; then
        swaymsg "output * dpms off";
    fi
fi
