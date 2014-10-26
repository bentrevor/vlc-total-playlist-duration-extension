-- Playlist total duration
-- Simple extension that shows the current playlist's total duration

-- Lua scripts are tried in alphabetical order in the user's VLC config directory
-- lua/{playlist,meta,intf}/ subdirectory on Windows and Mac OS X or in the user's
-- local share directory (~/.local/share/vlc/lua/... on linux), then in the global
-- VLC lua/{playlist,meta,intf}/ directory.

-- Extension description
function descriptor()
    return { title = "Playlist total duration" ;
             version = "1.1" ;
             author = "Ben Trevor" ;
             shortdesc = "Displays dialog box with current playlist's total duration";
             description = "Displays dialog box with current playlist's total duration" ;
             capabilities = { }
        }
end

-- Activation hook
function activate()
  window = vlc.dialog("playlist duration")
  window:add_button("refresh", update_duration, 1, 1, 1, 1)
  time_label = window:add_label("", 2, 1, 1, 1)
  get_playlist_duration()
  window:show()
end

function update_duration()
  get_playlist_duration()
end

function get_playlist_duration()
  local total = 0
  for key, value in pairs(vlc.playlist.get("playlist", false).children) do
    if value.duration ~= -1 then
      total = total + value.duration
    end
  end
  time_label:set_text(seconds_to_time(total))
  return total
end


-- convert time to readable format
function seconds_to_time(seconds)
  local hours = math.floor(seconds / 3600)
  local minutes = math.floor((seconds % 3600) / 60)
  local seconds = math.floor(seconds % 60)
  local hours_string = ""
  local minutes_string = ""
  local seconds_string = ""

  if hours == 1 then
    hours_string = "1 hour"
  else
    hours_string = tostring(hours) .. " hours"
  end

  if minutes == 1 then
    minutes_string = ", 1 minute"
  else
    minutes_string = ", " .. tostring(minutes) .. " minutes"
  end

  if seconds == 1 then
    seconds_string = ", 1 second"
  else
    seconds_string = ", " .. tostring(seconds) .. " seconds"
  end

  return hours_string .. minutes_string .. seconds_string
end

-- Deactivation hook
function deactivate()
end

-- stop the extension when the dialog window is closed
function close()
  vlc.deactivate()
end

-- stops debug error messages, which stops vlc from crashing.  I'm still not sure why...
function meta_changed()
end