#!/bin/bash
i3lock -i <(import -silent -window root png:- | mogrify -blur 0x8 png:-)
