import i3ipc
from subprocess import call
import subprocess

default = "dvorak_ger_io"
curlay = "dvorak_ger_io"

def get_win_id(i3):
    focused = i3.get_tree().find_focused()
    ws_name = "%s-%s"%(focused.workspace().num,focused.window_class)
    return ws_name

def on_focus(i3,e):
    global curlay
    name = get_win_id(i3)
    lay = default
    if "steam_app" in name: 
        lay = 'de'
    print("cur=",curlay,"desired=",lay)
    if curlay != lay:
        print("switching")
        if lay == 'dvorak_ger_io':
            call(["xmodmap","/home/ole/code/dvorak_ger_io/xmodmap/Xmodmap"])
        else:
            call(["setxkbmap","de"])
        curlay = lay

i3 = i3ipc.Connection()

i3.on("window::focus",on_focus)

i3.main()
