-- Transmit OSC message at beginning of sections and sequences.
renoise.tool().preferences = renoise.Document.create("PatternChangedPreferences") {
  osc_port = 8008
}

local port = renoise.tool().preferences.osc_port.value
local client, socket_error
local was_playing
local last_line
function test_for_pattern_change()
  local rs = renoise.song()
  local is_playing = renoise.song().transport.playing
  -- Return if not currently playing.
  if not is_playing then
    return
  end
  local current_line = rs.transport.playback_pos.line
  -- Trigger if just started playing or the line number got smaller.
  if (not was_playing and is_playing) or (last_line and current_line < last_line) then
    local current_sequence = rs.transport.playback_pos.sequence
    client:send(renoise.Osc.Message("/renoise/song/sequence", {
      { tag="s", value=rs.sequencer:sequence_section_name(current_sequence) },
      { tag="i", value=rs.transport.lpb },
      { tag="i", value=rs.patterns[rs.sequencer.pattern_sequence[current_sequence] ].number_of_lines },
      { tag="i", value=current_sequence }
    }))
   end
   was_playing = is_playing
   last_line = current_line
end
if not (renoise.tool().app_idle_observable:has_notifier(test_for_pattern_change)) then
  print('Starting PatternChanged on port ' .. port .. '.')
  client, socket_error = renoise.Socket.create_client("localhost", port, renoise.Socket.PROTOCOL_UDP)
  if (socket_error) then 
    renoise.app():show_warning(("Failed to start the OSC client. Error: '%s'"):format(socket_error))
  end
  renoise.tool().app_idle_observable:add_notifier(test_for_pattern_change)
end
