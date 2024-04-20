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

local edl_lines = {header_edl}

local total_lines = 0
for line in io.lines(args.file) do total_lines = total_lines + 1 end

local line_num = 1

local is_inside_section = false
local current_section_type = nil
local unnamed, named, named_order = {}, {}, {}

for line in io.lines(args.file) do

  if line_num == 1 and line == header_ezedl then

    goto next_line

  elseif line:match('^%s*$') or line:match('^[#;]') then

    goto next_line

  end

  ::end_section::

  if is_inside_section == false and line:match('^%[.*%]$') then
  
    is_inside_section = true
    current_section_type = line:match('^%[(.*)%]$')

    if current_section_type == 'empty line' then
      if args.include_empty_lines == true then
        table.insert(edl_lines, '')
      end
    elseif current_section_type ~= 'comment' and
           current_section_type ~= 'header' and
           current_section_type ~= 'segment' then
      print('error')
      os.exit(1)
    end

  else

    if line:match('^%[.*%]$') or end_of_file == true then

      if #unnamed > 0 or #named > 0 then

        local edl_line = ''

        if current_section_type == 'header' then

          if unnamed[1] ~= nil then
            edl_line = edl_line .. '!' .. unnamed[1] .. ','
          end

          for _, k in ipairs(named_order) do
            edl_line = edl_line .. string.format('%s=%%%s%%%s,', k, #named[k], named[k])
          end

        elseif current_section_type == 'segment' then

          if unnamed[1] ~= nil then
            edl_line = edl_line .. string.format('%%%s%%%s,', #unnamed[1], unnamed[1])
          end

          if unnamed[2] ~= nil then
            edl_line = edl_line .. unnamed[2] .. ','
          end

          if unnamed[3] ~= nil then
            edl_line = edl_line .. unnamed[3] .. ','
          end

          for _, k in ipairs(named_order) do
            edl_line = edl_line .. string.format('%s=%%%s%%%s,', k, #named[k], named[k])
          end

        end

        edl_line = edl_line:sub(1, -2)

        table.insert(edl_lines, edl_line)

      end

      is_inside_section = false
      unnamed, named, named_order = {}, {}, {}

      if end_of_file == true then break end
      goto end_section

    end

    local k, v = line:match('^([^=%s]+)%s*=%s*(.*)')
    if v:match('^[\'"].*[\'"]$') then
      local f = load('return ' .. v)
      v = f()
    end

    if current_section_type == 'comment' then

      if args.include_comments == true and k == 'content' then
        table.insert(edl_lines, string.format('#%s', v))
      end

    elseif current_section_type == 'header' then

      if k == 'type' then
        unnamed[1] = string.format('%s', v)
      else
        table.insert(named_order, k)
        named[k] = v
      end

    elseif current_section_type == 'segment' then

      if k == 'file' then
        unnamed[1] = string.format('%s', v)
      elseif k == 'start' then
        unnamed[2] = string.format('%s', timestamp_to_seconds(v))
      elseif k == 'end' then
        unnamed[3] = string.format('%s', timestamp_to_seconds(v)) - unnamed[2]
      elseif k == 'length' then
        unnamed[3] = string.format('%s', v)
      else
        table.insert(named_order, k)
        named[k] = v
      end

    end

  end

  ::next_line::

  if line_num == total_lines then
    end_of_file = true
    goto end_section
  end

  line_num = line_num + 1

end

for _, v in ipairs(edl_lines) do print(v) end
