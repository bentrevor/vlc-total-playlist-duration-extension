-- Playlist total duration
-- Simple extension that shows the current playlist's total duration

-- Extension description
function descriptor()
    return { title = "Playlist total duration" ;
             version = "1.0" ;
             author = "Ben Trevor" ;
             shortdesc = "Displays dialog box with current playlist's total duration";
             description = "Displays dialog box with current playlist's total duration" ;
             capabilities = { }
        }
end

-- Activation hook
function activate()
  dlg = vlc.dialog("playlist duration")
  local pl = vlc.playlist.get("playlist", false)
  local total = 0

  for key, value in pairs(pl.children) do
    if value.duration ~= -1 then
      total = total + value.duration
    end
  end

  dlg:add_html("<p>" .. seconds_to_time(total) .. "</p>")
  dlg:show()
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