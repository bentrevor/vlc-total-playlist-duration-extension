# Run this script from the command line and pass a .xspf file as the argument

from xml.etree.ElementTree import ElementTree
import sys

xmldoc = ElementTree()
try:
  xmldoc.parse(sys.argv[1])
except IndexError:
  sys.exit("you must pass the playlist file as a command line argument")
except:
  sys.exit("that file probably isn't a .xspf playlist file...")

root = xmldoc.getroot()
tracklist = root[1]

total = 0

for track in tracklist:
  for element in track:
    if element.tag.split('}')[1] == 'duration':
      total += int(element.text)

total /= 1000

hours = total / 3600
hours_string = "1 hour" if (hours == 1) else str(hours) + " hours"

minutes = (total % 3600) / 60
minutes_string = "1 minute" if (minutes == 1) else str(minutes) + " minutes"

seconds = total % 60
seconds_string = "1 second" if (seconds == 1) else str(seconds) + " seconds"

print hours_string + ", " + minutes_string + ", " + seconds_string