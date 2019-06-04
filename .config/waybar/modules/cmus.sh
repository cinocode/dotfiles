#!/bin/sh
playstat=`cmus-remote -Q | grep 'status playing'`

if [[ $playstat ]]; then
    artist=`cmus-remote -Q | grep 'tag artist' | cut -d ' ' -f 3-`
    album=`cmus-remote -Q | grep 'tag album ' | cut -d ' ' -f 3-`
    song=`cmus-remote -Q | grep 'tag title' | cut -d ' ' -f 3-`

    echo -e "{\"text\":\""🎶 $artist - $album - $song"\", \"class\":\"""\"}"
else
    pausestat=`cmus-remote -Q | grep 'status paused'`
    if [[ $pausestat ]]; then
        artist=`cmus-remote -Q | grep 'tag artist' | cut -d ' ' -f 3-`
        album=`cmus-remote -Q | grep 'tag album ' | cut -d ' ' -f 3-`
        song=`cmus-remote -Q | grep 'tag title' | cut -d ' ' -f 3-`

        echo -e "{\"text\":\""$artist - $album - $song"\", \"class\":\"""\"}"
    else
        echo -e "{\"text\":\"""\", \"class\":\"""\"}"
    fi
fi
