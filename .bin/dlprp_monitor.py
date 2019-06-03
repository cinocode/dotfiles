import glob, os, time, re

def down_jpg():
    os.chdir(os.path.expanduser("~/down"))
    for file in glob.glob("*.jpg_large"):
        print(file)
        os.rename(file, file[0:-6])

def home_numbers():
    os.chdir(os.path.expanduser("~"))
    for file in glob.glob("*"):
        if (re.search(r'^[0-9]{6}.+flv$', file)):
            print(file)
            os.rename(file, file[+8:])

while 1 == 1:
    down_jpg()
    home_numbers()
    time.sleep(2)
