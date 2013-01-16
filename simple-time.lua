-- Playlist total duration
-- Simple extension that shows the current playlist's total duration

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
  window:add_button("refresh", update_duration)
  time_list = window:add_list()

  get_playlist_duration(pl)
  window:show()
end

function update_duration()
  time_list:clear()
  get_playlist_duration()
end

function get_playlist_duration()
  local total = 0
  for key, value in pairs(vlc.playlist.get("playlist", false).children) do
    if value.duration ~= -1 then
      total = total + value.duration
    end
  end
  time_list:add_value(seconds_to_time(total))
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