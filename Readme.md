This is a simple extension I made for VLC Media Player that shows the total duration of the items in the playlist.  I also included my hastily-written python script that can calculate the duration from a .xspf file that is saved from VLC.

To install:
>Lua scripts are tried in alphabetical order in the user's VLC config directory lua/{playlist,meta,intf}/ subdirectory on Windows and Mac OS X or in the user's local share directory (~/.local/share/vlc/lua/... on linux), then in the global VLC lua/{playlist,meta,intf}/ directory.

To use:
There is a new item in the "View" menu that says "playlist total duration", which pops up a dialog box that shows the total playlist length.