#!/bin/bash
xset dpms force off &
sleep 2 && xset +dpms dpms 0 60 &
i3lock -n --color=121212 && xset s off -dpms

#i3lock -n -i <(import -silent -window root png:- | mogrify -blur 0x8 png:- | composite -gravity South -geometry +800+900 ~/.config/overlay.png png:- png:-) && xset s off -dpms
