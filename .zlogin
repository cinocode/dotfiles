if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    sh ~/.config/sway/setup
    printf "Start i3/sway/none? (i/s/n)"
    read -t 1 -k 1 answer
    case $answer in
        [Nn]* ) echo 'doing nothing';;
        [Ii]* ) startx;;
        [Ss]* ) sway;;
        * ) sway;;
    esac
fi
