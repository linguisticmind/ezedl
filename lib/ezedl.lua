-- ezedl - an mpv EDL preprocessor
-- copyright (c) 2024  Alex Rogers <https://github.com/linguisticmind>
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.

function convert_bash_boolean(v)
  if v == nil then return v end
  return v ~= '' and true or false
end

args = {
  file = arg[1],
  direction = arg[2],
  convert_timestamps = convert_bash_boolean(arg[3]),
  convert_length_to_end = convert_bash_boolean(arg[4]),
  include_empty_lines = convert_bash_boolean(arg[5]),
  include_comments = convert_bash_boolean(arg[6])
}

script_dir = arg[0]:match('^(.*)/.*$')

header_edl = '# mpv EDL v0'
header_ezedl = '# ezEDL v0' 

function seconds_to_timestamp(t)
  local s_ms = t % 60
  local r = t - s_ms
  local h = math.floor(r / 3600)
  r = r - (h * 3600)
  local m = r / 60
  local s, ms = string.format('%.03f', s_ms):match('([^.]*).(.*)')
  return string.format('%02d:%02d:%02d.%03d', h, m, s, ms)
end

function timestamp_to_seconds(t)
  local h, m, s = string.match(t, '^(%d%d):(%d%d):(%d%d%.%d+)$')
  return h == nil and t or h * 3600 + m * 60 + s
end

if args.direction == 'to' then
  dofile(script_dir .. '/ezedl_to.lua')
elseif args.direction == 'from' then
  dofile(script_dir .. '/ezedl_from.lua')
end
