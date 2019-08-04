#!/bin/bash
sh ~/.config/sway/setup
echo '#!/bin/bash' > ~/.config/wallpaper/set
echo 'swaymsg output "*" background ~/.config/wallpaper/background.png fill' >> ~/.config/wallpaper/set
chmod +x ~/.config/wallpaper/set
cp ~/.config/dots/proxy.sample ~/.config/dots/proxy
touch ~/.config/dots/gitconfig.local
touch ~/.config/dots/zshrc.local
