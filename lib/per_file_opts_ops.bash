# ezedl - an mpv EDL preprocessor
# copyright (c) 2024  Alex Rogers <https://github.com/linguisticmind>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# Comment headers: `+++` denotes the beginning of a section; `~~~`, its end.

# +++ Setting the index 0 value of `opts_*` arrays to the corresponding `opt_*` value +++

# This vim command can be applied to a line-selected list of `opts_*` variables with one variable per line.
# '<,'>s/\v^opts_(.*)/[[ ${#&[@]} = 0 ]] \&\& &[0]="$opt_\1"
# For options that distinguish empty strings from unset values, the following command can be run:
# '<,'>s/\v^opts_(.*)/[[ ${#&[@]} = 0 ]] \&\& unset '&[0]'

[[ ${#opts_edit_keep_temporary[@]} = 0 ]] && opts_edit_keep_temporary[0]="$opt_edit_keep_temporary"
[[ ${#opts_edit_save_file[@]} = 0 ]] && unset 'opts_edit_save_file[0]'
[[ ${#opts_edit_save_mkdir[@]} = 0 ]] && opts_edit_save_mkdir[0]="$opt_edit_save_mkdir"
[[ ${#opts_edit_save_overwrite[@]} = 0 ]] && opts_edit_save_overwrite[0]="$opt_edit_save_overwrite"
[[ ${#opts_edit_open_if_exists[@]} = 0 ]] && opts_edit_open_if_exists[0]="$opt_edit_open_if_exists"
[[ ${#opts_convert_timestamps[@]} = 0 ]] && opts_convert_timestamps[0]="$opt_convert_timestamps"
[[ ${#opts_convert_length_to_end[@]} = 0 ]] && opts_convert_length_to_end[0]="$opt_convert_length_to_end"
[[ ${#opts_include_empty_lines[@]} = 0 ]] && opts_include_empty_lines[0]="$opt_include_empty_lines"
[[ ${#opts_include_comments[@]} = 0 ]] && opts_include_comments[0]="$opt_include_comments"
[[ ${#opts_direction[@]} = 0 ]] && opts_direction[0]="$opt_direction"
[[ ${#opts_direction_auto_extension_no_header[@]} = 0 ]] && opts_direction_auto_extension_no_header[0]="$opt_direction_auto_extension_no_header"
[[ ${#opts_direction_auto_header_no_extension[@]} = 0 ]] && opts_direction_auto_header_no_extension[0]="$opt_direction_auto_header_no_extension"
[[ ${#opts_direction_auto_fallback[@]} = 0 ]] && opts_direction_auto_fallback[0]="$opt_direction_auto_fallback"
[[ ${#opts_direction_auto_no_header_no_extension[@]} = 0 ]] && opts_direction_auto_no_header_no_extension[0]="$opt_direction_auto_no_header_no_extension"
[[ ${#opts_direction_manual_extension_no_header[@]} = 0 ]] && opts_direction_manual_extension_no_header[0]="$opt_direction_manual_extension_no_header"
[[ ${#opts_direction_manual_header_no_extension[@]} = 0 ]] && opts_direction_manual_header_no_extension[0]="$opt_direction_manual_header_no_extension"
[[ ${#opts_direction_manual_no_header_no_extension[@]} = 0 ]] && opts_direction_manual_no_header_no_extension[0]="$opt_direction_manual_no_header_no_extension"

# ~~~ Setting the index 0 value of `opts_*` arrays to the corresponding `opt_*` value ~~~

# +++ Filling the `opts_*` arrays with values according to the number of files passed +++

for ((i=2; i<=$#; i++)); do

  # This vim command can be applied to a line-selected list of `opts_*` variables with one variable per line.
  # '<,'>s/.*/  [[ ! "${&[$((i - 1))]+_}" \&\& "${&[$((i - 2))]+_}" ]] \&\& &[$((i - 1))]="${&[$((i - 2))]}"
  # For custom inheritance rules, the conditional statement may be adjusted.

  [[ ! "${opts_edit_keep_temporary[$((i - 1))]+_}" && "${opts_edit_keep_temporary[$((i - 2))]+_}" ]] && opts_edit_keep_temporary[$((i - 1))]="${opts_edit_keep_temporary[$((i - 2))]}"
  [[ ! "${opts_edit_save_file[$((i - 1))]+_}" && ("${opts_edit_save_file[$((i - 2))]+_}" && "${opts_edit_save_file[$((i - 2))]+_}" = !(*.?(ez)edl)) ]] && opts_edit_save_file[$((i - 1))]="${opts_edit_save_file[$((i - 2))]}"
  [[ ! "${opts_edit_save_mkdir[$((i - 1))]+_}" && "${opts_edit_save_mkdir[$((i - 2))]+_}" ]] && opts_edit_save_mkdir[$((i - 1))]="${opts_edit_save_mkdir[$((i - 2))]}"
  [[ ! "${opts_edit_save_overwrite[$((i - 1))]+_}" && "${opts_edit_save_overwrite[$((i - 2))]+_}" ]] && opts_edit_save_overwrite[$((i - 1))]="${opts_edit_save_overwrite[$((i - 2))]}"
  [[ ! "${opts_edit_open_if_exists[$((i - 1))]+_}" && "${opts_edit_open_if_exists[$((i - 2))]+_}" ]] && opts_edit_open_if_exists[$((i - 1))]="${opts_edit_open_if_exists[$((i - 2))]}"
  [[ ! "${opts_convert_timestamps[$((i - 1))]+_}" && "${opts_convert_timestamps[$((i - 2))]+_}" ]] && opts_convert_timestamps[$((i - 1))]="${opts_convert_timestamps[$((i - 2))]}"
  [[ ! "${opts_convert_length_to_end[$((i - 1))]+_}" && "${opts_convert_length_to_end[$((i - 2))]+_}" ]] && opts_convert_length_to_end[$((i - 1))]="${opts_convert_length_to_end[$((i - 2))]}"
  [[ ! "${opts_include_empty_lines[$((i - 1))]+_}" && "${opts_include_empty_lines[$((i - 2))]+_}" ]] && opts_include_empty_lines[$((i - 1))]="${opts_include_empty_lines[$((i - 2))]}"
  [[ ! "${opts_include_comments[$((i - 1))]+_}" && "${opts_include_comments[$((i - 2))]+_}" ]] && opts_include_comments[$((i - 1))]="${opts_include_comments[$((i - 2))]}"
  [[ ! "${opts_direction[$((i - 1))]+_}" && "${opts_direction[$((i - 2))]+_}" ]] && opts_direction[$((i - 1))]="${opts_direction[$((i - 2))]}"
  [[ ! "${opts_direction_auto_extension_no_header[$((i - 1))]+_}" && "${opts_direction_auto_extension_no_header[$((i - 2))]+_}" ]] && opts_direction_auto_extension_no_header[$((i - 1))]="${opts_direction_auto_extension_no_header[$((i - 2))]}"
  [[ ! "${opts_direction_auto_header_no_extension[$((i - 1))]+_}" && "${opts_direction_auto_header_no_extension[$((i - 2))]+_}" ]] && opts_direction_auto_header_no_extension[$((i - 1))]="${opts_direction_auto_header_no_extension[$((i - 2))]}"
  [[ ! "${opts_direction_auto_fallback[$((i - 1))]+_}" && "${opts_direction_auto_fallback[$((i - 2))]+_}" ]] && opts_direction_auto_fallback[$((i - 1))]="${opts_direction_auto_fallback[$((i - 2))]}"
  [[ ! "${opts_direction_auto_no_header_no_extension[$((i - 1))]+_}" && "${opts_direction_auto_no_header_no_extension[$((i - 2))]+_}" ]] && opts_direction_auto_no_header_no_extension[$((i - 1))]="${opts_direction_auto_no_header_no_extension[$((i - 2))]}"
  [[ ! "${opts_direction_manual_extension_no_header[$((i - 1))]+_}" && "${opts_direction_manual_extension_no_header[$((i - 2))]+_}" ]] && opts_direction_manual_extension_no_header[$((i - 1))]="${opts_direction_manual_extension_no_header[$((i - 2))]}"
  [[ ! "${opts_direction_manual_header_no_extension[$((i - 1))]+_}" && "${opts_direction_manual_header_no_extension[$((i - 2))]+_}" ]] && opts_direction_manual_header_no_extension[$((i - 1))]="${opts_direction_manual_header_no_extension[$((i - 2))]}"
  [[ ! "${opts_direction_manual_no_header_no_extension[$((i - 1))]+_}" && "${opts_direction_manual_no_header_no_extension[$((i - 2))]+_}" ]] && opts_direction_manual_no_header_no_extension[$((i - 1))]="${opts_direction_manual_no_header_no_extension[$((i - 2))]}"

done

# ~~~ Filling the `opts_*` arrays with values according to the number of files passed ~~~

function set_per_file_opt {

  local i=$(($1 - 1))

  # This vim command can be applied to a line-selected list of `opts_*` variables with one variable per line.
  # '<,'>s/\v^opts_(.*)/  opt_\1="${&[$i]}"
  # For options that distinguish empty strings from unset values, the following command can be run:
  # '<,'>s/\v^opts_(.*)/  [[ ${&[$i]+_} ]] \&\& opt_\1="${&[$i]}" || unset opt_\1

  opt_edit_keep_temporary="${opts_edit_keep_temporary[$i]}"
  [[ ${opts_edit_save_file[$i]+_} ]] && opt_edit_save_file="${opts_edit_save_file[$i]}" || unset opt_edit_save_file
  opt_edit_save_mkdir="${opts_edit_save_mkdir[$i]}"
  opt_edit_save_overwrite="${opts_edit_save_overwrite[$i]}"
  opt_edit_open_if_exists="${opts_edit_open_if_exists[$i]}"
  opt_convert_timestamps="${opts_convert_timestamps[$i]}"
  opt_convert_length_to_end="${opts_convert_length_to_end[$i]}"
  opt_include_empty_lines="${opts_include_empty_lines[$i]}"
  opt_include_comments="${opts_include_comments[$i]}"
  opt_direction="${opts_direction[$i]}"
  opt_direction_auto_extension_no_header="${opts_direction_auto_extension_no_header[$i]}"
  opt_direction_auto_header_no_extension="${opts_direction_auto_header_no_extension[$i]}"
  opt_direction_auto_fallback="${opts_direction_auto_fallback[$i]}"
  opt_direction_auto_no_header_no_extension="${opts_direction_auto_no_header_no_extension[$i]}"
  opt_direction_manual_extension_no_header="${opts_direction_manual_extension_no_header[$i]}"
  opt_direction_manual_header_no_extension="${opts_direction_manual_header_no_extension[$i]}"
  opt_direction_manual_no_header_no_extension="${opts_direction_manual_no_header_no_extension[$i]}"

  if [[ ${opt_edit_save_file+_} || $opt_edit_open_if_exists ]]; then

    case $opt_edit_save_file in
      */*.?(ez)edl )
        save_path="${opt_edit_save_file%/*}"
        save_name="${opt_edit_save_file##*/}"
      ;;
      *.?(ez)edl ) 
        save_name="${opt_edit_save_file##*/}"
      ;;
      !(*.?(ez)edl) )
        save_path="${opt_edit_save_file%%+(/)}"
      ;;
    esac

    [[ ! $save_path ]] && save_path="$PWD"

  fi

  case $opt_direction in
    auto | to | from ) ;;
    * )
      printf \
        ${opt_color:+'\x1b[31m'}'[%s] %s'${opt_color:+'\x1b[39m'}'\n' \
        "${BASH_SOURCE[$((${#BASH_SOURCE[@]} - 1))]##*/}" \
        'Invalid argument to `--direction` for file #'"$1"' ('\'"${2//\'/\'\\\'\'}"\''): '\'"${opt_direction//\'/\'\\\'\'}"\''. Allowed values are `auto`, `to` and `from`.' >&2
      had_errors=1
    ;;
  esac

  case $opt_direction_auto_extension_no_header in
    warning | error | quiet ) ;;
    * )
      printf \
        ${opt_color:+'\x1b[31m'}'[%s] %s'${opt_color:+'\x1b[39m'}'\n' \
        "${BASH_SOURCE[$((${#BASH_SOURCE[@]} - 1))]##*/}" \
        'Invalid argument to `--direction-auto-extension-no-header` for file #'"$1"' ('\'"${2//\'/\'\\\'\'}"\''): '\'"${opt_direction_auto_extension_no_header//\'/\'\\\'\'}"\''. Allowed values are `warning`, `error` and `quiet`.' >&2
      had_errors=1
    ;;
  esac

  case $opt_direction_auto_header_no_extension in
    warning | error | quiet ) ;;
    * )
      printf \
        ${opt_color:+'\x1b[31m'}'[%s] %s'${opt_color:+'\x1b[39m'}'\n' \
        "${BASH_SOURCE[$((${#BASH_SOURCE[@]} - 1))]##*/}" \
        'Invalid argument to `--direction-auto-header-no-extension` for file #'"$1"' ('\'"${2//\'/\'\\\'\'}"\''): '\'"${opt_direction_auto_header_no_extension//\'/\'\\\'\'}"\''. Allowed values are `warning`, `error` and `quiet`.' >&2
      had_errors=1
    ;;
  esac

  case $opt_direction_auto_fallback in
    to | from ) ;;
    * )
      printf \
        ${opt_color:+'\x1b[31m'}'[%s] %s'${opt_color:+'\x1b[39m'}'\n' \
        "${BASH_SOURCE[$((${#BASH_SOURCE[@]} - 1))]##*/}" \
        'Invalid argument to `--direction-auto-fallback` for file #'"$1"' ('\'"${2//\'/\'\\\'\'}"\''): '\'"${opt_direction_auto_fallback//\'/\'\\\'\'}"\''. Allowed values are `to` and `from`.' >&2
      had_errors=1
    ;;
  esac

  case $opt_direction_auto_no_header_no_extension in
    warning?(,?(to|from)) | error | quiet?(,?(to|from)) ) ;;
    * )
      printf \
        ${opt_color:+'\x1b[31m'}'[%s] %s'${opt_color:+'\x1b[39m'}'\n' \
        "${BASH_SOURCE[$((${#BASH_SOURCE[@]} - 1))]##*/}" \
        'Invalid argument to `--direction-auto-no-header-no-extension` for file #'"$1"' ('\'"${2//\'/\'\\\'\'}"\''): '\'"${opt_direction_auto_no_header_no_extension//\'/\'\\\'\'}"\''. Allowed values are `warning`, `warning,to`, `warning,from`, `error`, `quiet`, `quiet,to`, `quiet,from`.' >&2
      had_errors=1
    ;;
  esac

  case $opt_direction_manual_extension_no_header in
    warning | error | quiet ) ;;
    * )
      printf \
        ${opt_color:+'\x1b[31m'}'[%s] %s'${opt_color:+'\x1b[39m'}'\n' \
        "${BASH_SOURCE[$((${#BASH_SOURCE[@]} - 1))]##*/}" \
        'Invalid argument to `--direction-manual-extension-no-header` for file #'"$1"' ('\'"${2//\'/\'\\\'\'}"\''): '\'"${opt_direction_manual_extension_no_header//\'/\'\\\'\'}"\''. Allowed values are `warning`, `error` and `quiet`.' >&2
      had_errors=1
    ;;
  esac

  case $opt_direction_manual_header_no_extension in
    warning | error | quiet ) ;;
    * )
      printf \
        ${opt_color:+'\x1b[31m'}'[%s] %s'${opt_color:+'\x1b[39m'}'\n' \
        "${BASH_SOURCE[$((${#BASH_SOURCE[@]} - 1))]##*/}" \
        'Invalid argument to `--direction-manual-header-no-extension` for file #'"$1"' ('\'"${2//\'/\'\\\'\'}"\''): '\'"${opt_direction_manual_header_no_extension//\'/\'\\\'\'}"\''. Allowed values are `warning`, `error` and `quiet`.' >&2
      had_errors=1
    ;;
  esac

  case $opt_direction_manual_no_header_no_extension in
    warning | error | quiet ) ;;
    * )
      printf \
        ${opt_color:+'\x1b[31m'}'[%s] %s'${opt_color:+'\x1b[39m'}'\n' \
        "${BASH_SOURCE[$((${#BASH_SOURCE[@]} - 1))]##*/}" \
        'Invalid argument to `--direction-manual-no-header-no-extension` for file #'"$1"' ('\'"${2//\'/\'\\\'\'}"\''): '\'"${opt_direction_manual_no_header_no_extension//\'/\'\\\'\'}"\''. Allowed values are `warning`, `error` and `quiet`.' >&2
      had_errors=1
    ;;
  esac

}
