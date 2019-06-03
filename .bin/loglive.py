import os, sys, subprocess, time
from subprocess import *

#scriptpath = os.path.dirname(os.path.abspath(sys.argv[0]))

gdir = sys.argv[1]
amount = '60'
seconds = 10
if (len(sys.argv) > 2):
    amount = sys.argv[2]
    if (len(sys.argv) > 3):
        seconds = sys.argv[3]
os.chdir(gdir)

prevtext = ''
while 1:
    try:
        text = getoutput('git lm --max-count ' + amount)
        
        if text != prevtext:
            os.system('clear')
            print(text)
        
        prevtext = text
        time.sleep(seconds)
    except (KeyboardInterrupt, SystemExit):
        sys.exit(0)
