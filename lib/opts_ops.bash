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

if [[ ! $opt_edit && $# -gt 1 ]]; then
  printf \
    ${opt_color:+'\x1b[31m'}'[%s] %s'${opt_color:+'\x1b[39m'}'\n' \
    "${BASH_SOURCE[$((${#BASH_SOURCE[@]} - 1))]##*/}" \
    'Too many arguments: multiple files can only be passed in edit mode (`-e, --edit`).' >&2
  exit 1
fi

case $opt_editor in
  vim | nvim | custom | auto ) ;;
  * )
    printf \
      ${opt_color:+'\x1b[31m'}'[%s] %s'${opt_color:+'\x1b[39m'}'\n' \
      "${BASH_SOURCE[$((${#BASH_SOURCE[@]} - 1))]##*/}" \
      'Invalid argument to `-V, --editor`: '\'"${opt_editor//\'/\'\\\'\'}"\''. Allowed values are `vim`, `nvim`, `custom` and `auto`.' >&2
    exit 1
  ;;
esac

if [[ $opt_edit && $opt_editor = 'auto' ]]; then
  if [[ ${VISUAL:-$EDITOR} &&
        (${VISUAL:-$EDITOR} = 'vim' || ${VISUAL:-$EDITOR} = 'nvim') ]]; then
    opt_editor="${VISUAL:-$EDITOR}"
  else
    if type -P vim > /dev/null; then
      opt_editor='vim'
    elif type -P nvim > /dev/null; then
      opt_editor='nvim'
    else
      opt_editor='custom'
    fi
  fi
fi

case $opt_vim_layout in
  simple | split | tab ) ;;
  * )
    printf \
      ${opt_color:+'\x1b[31m'}'[%s] %s'${opt_color:+'\x1b[39m'}'\n' \
      "${BASH_SOURCE[$((${#BASH_SOURCE[@]} - 1))]##*/}" \
      'Invalid argument to `-v, --vim-layout`: '\'"${opt_vim_layout//\'/\'\\\'\'}"\''. Allowed values are `simple`, `split` and `tab`.' >&2
    exit 1
  ;;
esac

case $opt_vim_split_height in
  '' | +([[:digit:]]) ) ;;
  * )
    printf \
      ${opt_color:+'\x1b[31m'}'[%s] %s'${opt_color:+'\x1b[39m'}'\n' \
      "${BASH_SOURCE[$((${#BASH_SOURCE[@]} - 1))]##*/}" \
      'Invalid argument to `-v, --vim-split-height`: '\'"${opt_vim_split_height//\'/\'\\\'\'}"\''. Only positive integer values and an empty string are allowed.' >&2
    exit 1
  ;;
esac
