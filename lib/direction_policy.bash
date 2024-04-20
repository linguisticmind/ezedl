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

function apply_direction_policy {

  local resolve color fallback

  function msg_if_direction_manual {

    if [[ $opt_direction = 'to' || $opt_direction = 'from' ]]; then
      messages+=("$(
        printf \
          ${opt_color:+'\x1b['"$color"'m'}'[%s] %s'${opt_color:+'\x1b[39m'}'\n' \
          "${BASH_SOURCE[$((${#BASH_SOURCE[@]} - 1))]##*/}" \
          'Conversion direction (`--direction`) has been set manually to '\'"${opt_direction//\'/\'\\\'\'}"\''.'
      )")
    fi

  }

  function apply_direction_policy_extension_no_header {

    case $opt_direction in
      auto ) resolve="$opt_direction_auto_extension_no_header" ;;
      to | from ) resolve="$opt_direction_manual_extension_no_header" ;;
    esac
    case $resolve in
      warning ) color='33' ;;
      error ) color='31' ;;
    esac

    if [[ $resolve = 'warning' || $resolve = 'error' ]]; then
      messages+=("$(
        printf \
          ${opt_color:+'\x1b['"$color"'m'}'[%s] %s'${opt_color:+'\x1b[39m'}'\n' \
          "${BASH_SOURCE[$((${#BASH_SOURCE[@]} - 1))]##*/}" \
          "$1"
      )")
      msg_if_direction_manual
      [[ $resolve = 'error' ]] && had_errors=1
    fi

  }

  function apply_direction_policy_header_no_extension {

    case $opt_direction in
      auto ) resolve="$opt_direction_auto_header_no_extension" ;;
      to | from ) resolve="$opt_direction_manual_header_no_extension" ;;
    esac
    case $resolve in
      warning ) color='33' ;;
      error ) color='31' ;;
    esac

    if [[ $resolve = 'warning' || $resolve = 'error' ]]; then
      messages+=("$(
        printf \
          ${opt_color:+'\x1b['"$color"'m'}'[%s] %s'${opt_color:+'\x1b[39m'}'\n' \
          "${BASH_SOURCE[$((${#BASH_SOURCE[@]} - 1))]##*/}" \
          "$1"
      )")
      msg_if_direction_manual
      [[ $resolve = 'error' ]] && had_errors=1
    fi

  }

  function apply_direction_policy_no_header_no_extension {

    case $opt_direction in
      auto ) resolve="$opt_direction_auto_no_header_no_extension" ;;
      to | from ) resolve="$opt_direction_manual_no_header_no_extension" ;;
    esac
    case $resolve in
      warning?(,?(to|from)) )
        color='33'
        case $resolve in
          warning?(,) ) fallback="$opt_direction_auto_fallback" ;;
          warning,to ) fallback='to' ;;
          warning,from ) fallback='from' ;;
        esac
      ;;
      error ) color='31' ;;
    esac

    if [[ $resolve = 'warning' || $resolve = 'error' ]]; then
      messages+=("$(
        printf \
          ${opt_color:+'\x1b['"$color"'m'}'[%s] %s'${opt_color:+'\x1b[39m'}'\n' \
          "${BASH_SOURCE[$((${#BASH_SOURCE[@]} - 1))]##*/}" \
          "$1"
      )")
      msg_if_direction_manual
      [[ $resolve = 'error' ]] && had_errors=1
    fi

  }

  case $1 in
    *.edl )
      if [[ $first_line != "$header_edl" ]]; then
        apply_direction_policy_extension_no_header \
          'File '\'"${1//\'/\'\\\'\'}"\'' has a `.edl` extension, but doesn'\''t have a proper header. The first line of the file should be precisely '\'"${header_edl//\'/\'\\\'\'}"\''. The first line of this file is '\'"${first_line//\'/\'\\\'\'}"\''.'
      fi
      [[ $opt_direction = 'auto' ]] && opt_direction='to'
    ;;
    *.ezedl )
      if [[ $first_line != "$header_ezedl" ]]; then
        apply_direction_policy_extension_no_header \
          'File '\'"${1//\'/\'\\\'\'}"\'' has a `.ezedl` extension, but doesn'\''t have a proper header. The first line of the file should be precisely '\'"${header_ezedl//\'/\'\\\'\'}"\''. The first line of this file is '\'"${first_line//\'/\'\\\'\'}"\''.' >&2
      fi
      [[ $opt_direction = 'auto' ]] && opt_direction='from'
    ;;
    * )
      case $first_line in
        "$header_edl" )
          apply_direction_policy_header_no_extension \
            'File '\'"${1//\'/\'\\\'\'}"\'' has an mpv EDL header ('\'"${header_ezedl//\'/\'\\\'\'}"\''), but doesn'\''t have a matching `.edl` extension.' >&2
          [[ $opt_direction = 'auto' ]] && opt_direction='to'
        ;;
        "$header_ezedl" )
          apply_direction_policy_header_no_extension \
            'File '\'"${1//\'/\'\\\'\'}"\'' has an ezEDL header ('\'"${header_ezedl//\'/\'\\\'\'}"\''), but doesn'\''t have a matching `.ezedl` extension.' >&2
          [[ $opt_direction = 'auto' ]] && opt_direction='from'
        ;;
        * )
          apply_direction_policy_no_header_no_extension \
            'File '\'"${1//\'/\'\\\'\'}"\'' has no recognized headers ('\'"${header_edl//\'/\'\\\'\'}"\'', '\'"${header_ezedl//\'/\'\\\'\'}"\'') or extensions (`.edl`, `.ezedl`).' >&2
          [[ $opt_direction = 'auto' ]] && opt_direction="$fallback"
        ;;
      esac
    ;;
  esac

}
