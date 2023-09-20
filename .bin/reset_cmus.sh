mkdir -p ~/.config/cmus
rm -rf ~/.config/cmus/*

echo unbind common + >> ~/.config/cmus/rc
echo bind common + vol +5% >> ~/.config/cmus/rc
echo unbind common - >> ~/.config/cmus/rc
echo bind common - vol -5% >> ~/.config/cmus/rc

echo set aaa_mode=artist >> ~/.config/cmus/rc
echo set follow=true >> ~/.config/cmus/rc
echo set repeat=true >> ~/.config/cmus/rc
echo set continue=true >> ~/.config/cmus/rc
echo set show_remaining_time=true >> ~/.config/cmus/rc
echo set shuffle=false >> ~/.config/cmus/rc
echo set status_display_program=cmusfm >> ~/.config/cmus/rc
