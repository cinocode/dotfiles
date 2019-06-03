if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    printf "Start sway/i3/none? (s/i/n)"
    read -t 1 -k 1 answer
    case $answer in
        [Nn]* ) echo 'doing nothing';;
        [Ii]* ) echo 'i3 not installed';;
        * ) sway;;
    esac
fi
