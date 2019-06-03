#!/bin/python
import requests
import re, os, sys
from bs4 import BeautifulSoup				# To parse webpage data and gather urls
from concurrent.futures import ThreadPoolExecutor 	# Enables concurrent downloads

## Input variables, change these as u need
album_url = sys.argv[1]
keys = [] 					# To download specific titles, example: ['puppy', 'dog', 'hound']
title_as_folder = False		# Default is current folder
simultaneous_workers = 8	# Max simultaneous downloads


## Parser
page = requests.get(album_url)
soup = BeautifulSoup(page.content, 'html.parser')

album = soup.find('div', {'id':'album'})
medias = album.find_all('div', {'class':'media-group'})	# Will raise exception if no album is found
videos = []
titles = []
for i, media in enumerate(medias):
	try: 
		videos.append(media.find('video').find('source', {'label':'HD'}).attrs['src'])
	except AttributeError:
		try:
			videos.append(media.find('video').find('source', {'label':'SD'}).attrs['src'])
		except AttributeError:
			continue
	titles.append(media.find('h2').get_text().replace('/','') if media.find('h2') is not None else ('Video '+ str(i)))

# Use page title as folder name
os.mkdir('/home/ole/down/errome');
if title_as_folder:
	title_txt = soup.find('title').get_text()
	folder = '/home/ole/down/errome/' + ''.join(s for s in title_txt if s.isalnum()) + '/'
else:
	folder = '/home/ole/down/errome/'
	
	
# Filter titles by matchin keys
if len(keys) > 0:
	tmp_titles = set()
	for key in keys:
		# '|=' add set items to tmp set
		tmp_titles |= {title for title in titles if key.lower() in title.lower()}
	
	if len(tmp_titles) > 0: # If matching title is found
		videos = list(map(videos.__getitem__, list(map(titles.index, tmp_titles))))
		titles = tmp_titles
	else:
		print('Key not found!')
		sys.exit()

sys.stdout.write('Downloading %d file(s) from %s\n' % (len(titles), album_url))
sys.stdout.flush()

# Downloads and writes to file using title
def download(url, title):
	filename = title + '.' + url.split('.')[-1]
	files = os.listdir(folder)  # List files in folder
	if filename in files:       # Skip file if already downloaded/downloading
		return

	# Download file from url
	r = requests.get(r'https://' + url[2-len(url):], stream=True)
	with open(folder + filename, 'wb') as f:
		for chunk in r.iter_content(chunk_size=1024):
			if chunk: # While alive
				f.write(chunk)
				f.flush()
				
# Download the videos, with 12 workers
with ThreadPoolExecutor(max_workers=simultaneous_workers) as executor:
	for url, title in zip(videos,titles):
		print('Downloading ' + title + '...')
		executor.submit(download, url, title)
		
sys.stdout.write("\n%d Downloads Finished!" % (len(videos)))
