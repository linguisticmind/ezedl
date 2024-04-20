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

local function parse_edl_arg(line)

  local name = line:match('^[^=%,;\n!]+=')
  local value
  local not_name, next_index

  if name ~= nil then
    name = name:sub(1, -2)
    not_name = line:sub(#name + 2)
  else
    not_name = line
  end

  if not_name:sub(1, 1) == '%' then

    local value_length = not_name:match('^%%(%d+)%%')
    local escape_length = #value_length + 2
    local escape_value_length = escape_length + value_length

    value = not_name:sub(escape_length + 1, escape_value_length)

    next_index = (name and #name + 1 or 0) + 1 + escape_value_length + 1

  else

    local delimiter_index = not_name:find(',') or #not_name + 1
    value = not_name:sub(1, delimiter_index - 1)
    next_index = (name and #name + 1 or 0) + delimiter_index + 1

  end

  return name, value, next_index

end

local ezedl_lines = {header_ezedl}

local line_num = 1

for line in io.lines(args.file) do

  if line:match('^%s*$') ~= nil then

    if args.include_empty_lines == true then 
      table.insert(ezedl_lines, '[empty line]')
    end

  elseif line:sub(1, 1) == '#' then

    if args.include_comments == true then

      if not (line_num == 1 and line == header_edl) then
        table.insert(ezedl_lines, '[comment]')
        table.insert(ezedl_lines, string.format('%s = %q', 'content', line:sub(2)))
      end

    end

  elseif line:sub(1, 1) == '!' then

    local ezedl_header, ezedl_header_order = {}, {}
    local arg_num = 1

    line = line:sub(2)

    while #line > 0 do

      local name, value, next_index = parse_edl_arg(line)

      local k, v

      if name == nil then
        if arg_num == 1 then
          k, v = 'type', value
        end
      else
        k, v = name, value
      end

      table.insert(ezedl_header_order, k)
      ezedl_header[k] = v

      line = line:sub(next_index)

      arg_num = arg_num + 1

    end

    table.insert(ezedl_lines, '[header]')
    for _, k in ipairs(ezedl_header_order) do
      table.insert(ezedl_lines, string.format('%s = %q', k, ezedl_header[k]))
    end

  else

    local ezedl_segment, ezedl_segment_order = {}, {}
    local arg_num = 1

    while #line > 0 do
      
      local name, value, next_index = parse_edl_arg(line)

      local k, v

      if name == nil then
        if arg_num == 1 then
          k, v = 'file', value
        elseif arg_num == 2 then
          k, v = 'start', tonumber(value)
        elseif arg_num == 3 then
          k, v = 'length', tonumber(value)
        end
      else
        k, v = name, value
      end

      table.insert(ezedl_segment_order, k)
      ezedl_segment[k] = v

      line = line:sub(next_index)

      arg_num = arg_num + 1

    end

    if ezedl_segment.timestamps == nil then
      local start, length = ezedl_segment.start, ezedl_segment.length
      if start ~= nil then
        if args.convert_timestamps == true then
          ezedl_segment.start = seconds_to_timestamp(start)
        end
      end
      if args.convert_length_to_end == true and length ~= nil then
        if args.convert_timestamps == true then
          ezedl_segment['end'] = seconds_to_timestamp(start + length)
        else
          ezedl_segment['end'] = start + length
        end
        ezedl_segment.length = nil
      end
    elseif ezedl_segment.timestamps == 'chapters' then
      if args.convert_length_to_end == true and ezedl_segment.length ~= nil then
        ezedl_segment['end'] = ezedl_segment.start + ezedl_segment.length
        ezedl_segment.length = nil
      end
    end

    if args.convert_length_to_end == true and ezedl_segment_order[3] == 'length' then
      ezedl_segment_order[3] = 'end'
    end

    table.insert(ezedl_lines, '[segment]')
    for _, k in ipairs(ezedl_segment_order) do
      local v = ezedl_segment[k]
      if type(v) == 'number' then
        table.insert(ezedl_lines, string.format('%s = %s', k, v))
      else
        table.insert(ezedl_lines, string.format('%s = %q', k, v))
      end 
    end

  end

  line_num = line_num + 1

end

i = 1
prev_section_is_comment = false
while i <= #ezedl_lines do
  if ezedl_lines[i]:match('^%[.*%]$') then
    if ezedl_lines[i]:match('^%[comment%]$') then
      if prev_section_is_comment == true then
        table.remove(ezedl_lines, i)
        i = i - 1
      end
      prev_section_is_comment = true
    else
      prev_section_is_comment = false
    end
  end
  i = i + 1
end

i = 1
while i <= #ezedl_lines do
  if ezedl_lines[i]:match('^%[.*%]$') then
    if not (ezedl_lines[i]:match('^%[empty line%]$') and ezedl_lines[i - 1]:match('^%[empty line%]$')) then
      table.insert(ezedl_lines, i, '')
      i = i + 1
    end
  end
  i = i + 1
end

for _, v in ipairs(ezedl_lines) do print(v) end
