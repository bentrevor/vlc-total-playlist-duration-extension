from xml.etree.ElementTree import ElementTree

xmldoc = ElementTree()
xmldoc.parse('/home/benjamin/Desktop/vlc_playlist.xspf')
root = xmldoc.getroot()
tracklist = root[1]

total_minutes = 0

for track in tracklist:
  for element in track:
    if element.tag.split('}')[1] == 'duration':
      total_minutes += int(element.text)

print total_minutes / 60000
