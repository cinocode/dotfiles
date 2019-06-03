import os, random, sys
os.system('mkdir -p /home/ole/dia')

for x in range(int(sys.argv[2])):
  for root, dirs, files in os.walk(sys.argv[1]):
      for file in files:
          if file.endswith(".jpg") or file.endswith(".jpeg") or file.endswith(".png") or file.endswith(".bmp") or file.endswith(".gif"):
              extension = os.path.splitext(file)[-1]
              os.system("ln '" + os.path.join(root, file) + "' '/home/ole/dia/" + str(random.randint(0, sys.maxsize)) + extension + "'")
