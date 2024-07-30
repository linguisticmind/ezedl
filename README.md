# ezedl

`ezedl` allows the user to create and edit mpv EDL files with ease. It greatly simplifies and makes more convenient the process of working with mpv EDL files in a plain text editor.

ezedl uses an [INI](https://en.wikipedia.org/wiki/INI_file)-like syntax to create mpv EDL elements such as segments and headers. Vim and Neovim integration is provided out of the box, allowing for easy editing, and on-the-fly compiling and previewing of mpv EDL files.

The official mpv EDL format documentation can be found here: https://github.com/mpv-player/mpv/blob/master/DOCS/edl-mpv.rst

Video tutorial:

[![Mindful Technology - ezedl: edit mpv EDL files conveniently (an mpv EDL preprocessor)](https://img.youtube.com/vi/h5O1whOBDeE/0.jpg)](https://www.youtube.com/watch?v=h5O1whOBDeE)

<a href='https://ko-fi.com/linguisticmind'><img src='https://github.com/linguisticmind/linguisticmind/raw/master/res/kofi/kofi_donate_1.svg' alt='Support me on Ko-fi' height='48'></a>

## Changelog

<table>
    <tr>
        <th>Version</th>
        <th>Date</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>
            <a href='https://github.com/linguisticmind/ezedl/releases/tag/v0.1.1'>0.1.1</a>
        </td>
        <td>
            2024-04-23
        </td>
        <td>
            <p>
                Updated the <code>editor_custom</code> function to <code>function editor_custom { nano "${dest_files[@]}"; }</code>.
            </p>
            <p>
                Fixed typos in the man page.
            </p>
        </td>
    </tr>
</table>

[Read more](CHANGELOG.md)

## Known issues

`vim`/`nvim` autocommands don't work quite right. Each opened file has to be saved first at least once for the next autocommand to work.

So, say, if you have three files open, and you want to save the third one, you have to run `:w` on the first and the second one at least once in order for the third autocommand to start responding.

So far, I was unable to figure out what the problem is. I opened an [issue](https://github.com/linguisticmind/ezedl/issues/1) that shows the Vim script that gets generated, so if anyone has any suggestions, I'd be glad to hear from you.

## Dependencies

### Lua

`ezedl` requires that [`lua`](https://www.lua.org/) (v5.4) be installed.

On Debian, run `sudo apt install lua5.4` to install it.

`lua` 5.4 is the version of `lua` that `ezedl` was tested with. `ezedl` first checks `PATH` for a binary called `lua5.4`, and if that is not available, it uses `lua` as a fallback binary name.

### A text editor

To use `ezedl`'s `-e, --edit` mode, a text editor is needed.

[Vim](https://www.vim.org/) (`vim`) or [Neovim](https://neovim.io/) (`nvim`) are strongly recommended since `ezedl` offers functionality that is unique to working with those text editors, and that greatly facilitates the process of editing, compiling and previewing ezEDL files.

On Debian, run `sudo apt install vim-gtk3` to install Vim. (The `gtk3` version of the package is recommended since it provides system clipboard integration out of the box.)

To install Neovim on Debian, run `sudo apt install neovim`.

### Other

`ezedl` was written and tested on Debian 12, and takes advantage of standard utilities that come with the system. In order to run `ezedl` on other systems, make sure that the following are installed and available on system's `PATH`:

* Bash >= 5.2.15
* Enhanced getopt
* GNU coreutils
* GNU sed

## Installation

1. Clone this repository to a directory of your choice (e.g. `~/repos`):

    ```bash
    cd ~/repos
    git clone https://github.com/linguisticmind/ezedl.git
    ```

2. Symlink or copy the [script file](ezedl) to a directory on your `PATH` (e.g. `~/bin`):

    ```bash
    cd ~/bin
    # To symlink:
    ln -sv ../repos/ezedl/ezedl
    # To copy:
    cp -av ../repos/ezedl/ezedl .
    ```

    Symlinking is recommended, otherwise you will have to do an additional step (see step 3).

3. If you copied the script file in step 2 instead of symlinking it, you will also need to copy the [`lib`](lib) directory to a location of your choice (e.g. `~/lib`), and set the `EZEDL_LIB_DIR` environment variable:

    ```bash
    cd ~/lib
    cp -av ../repos/ezedl/lib ezedl
    ```

    Now, add the following line to your `~/.bashrc` file (or other appropriate configuration file for your shell):

    ```bash
    export EZEDL_LIB_DIR="$HOME"'/lib/ezedl'
    ```

    Restart your terminal session for changes to take effect.

    You can also test the environment variable in your terminal session before adding it to the shell configuration file, like this:

    ```bash
    EZEDL_LIB_DIR="$HOME"'/lib/ezedl' ezedl <arguments to ezedl>
    ```

4. (OPTIONAL) Symlink or copy the [man page](man/man1/ezedl.1) to a directory on your `MANPATH` (e.g. `~/man`):

    ```bash
    cd ~/man/man1 # The `man` directory should contain subdirectories for different manual sections: `man1`, `man2` etc.
    # To symlink:
    ln -sv ../../repos/ezedl/man/man1/ezedl.1
    # To copy:
    cp -av ../../repos/ezedl/man/man1/ezedl.1 .
    ```

    A copy of the manual page is also [included in this README file](#manual).

5. (OPTIONAL) Copy the [example config file](config.bash) to the config directory:

    ```bash
    mkdir -v ~/.config/ezedl
    cp -v ~/repos/ezedl/config.bash ~/.config/ezedl
    ```

## Manual

```plain
EZEDL(1)                    General Commands Manual                   EZEDL(1)

NAME
       ezedl - an mpv EDL preprocessor

SYNOPSIS
        ezedl [<options>] [<file>]

        ezedl -e|--edit [<options>] [<file> ...]

DESCRIPTION
       ezedl  allows  the  user to create and edit mpv EDL files with ease. It
       greatly simplifies and makes more convenient  the  process  of  working
       with mpv EDL files in a plain text editor.

       ezedl  uses  an INI-like syntax to create mpv EDL elements such as seg‐
       ments and headers. Vim and Neovim integration is provided  out  of  the
       box, allowing for easy editing, and on-the-fly compiling and previewing
       of mpv EDL files.

       The  official  mpv  EDL  format  documentation  can  be   found   here:
       <https://github.com/mpv-player/mpv/blob/master/DOCS/edl-mpv.rst>.

       ezedl  requires  lua  (v5.4)  to be installed and available on system's
       PATH.

       To use ezedl's -e, --edit mode, a text editor is needed. Vim  (vim)  or
       Neovim (nvim) are strongly recommended since ezedl offers functionality
       that is unique to working with those text editors, and that greatly fa‐
       cilitates the process of editing, compiling and previewing ezEDL files.

OPTIONS
   Passing arguments to options
       Enhanced  getopt  syntax applies when passing options. There is one im‐
       portant point to highlight when it comes to passing  options  with  re‐
       quired vs optional arguments.

       In  case  of  a short option, if an option takes a *required* argument,
       the argument may be written as a separate parameter, *or* directly  af‐
       ter  the  option  character. If an option takes an *optional* argument,
       however, the argument *must* be written directly after the option char‐
       acter.

       In case of a long option, if an option takes a *required* argument, the
       argument may be written as a separate parameter,  *or*  directly  after
       the  option name, separated by an equals sign (`=`). If an option takes
       an *optional* argument, however, the argument *must*  be  writtent  di‐
       rectly after the option name, separated by an equals sign (`=`).

                           Short option   Long option
       Required argument   -o <value>     --option <value>
                           -o<value>      --option=<value>
       Optional argument   -o[<value>]    --option[=<value>]

       Options  that  take optional arguments can be recognized in the options
       list below by their <value> and the preceding  equals  sign  being  en‐
       closed in square brackets:

       -o, --option[=<value>]

   Per-file options
       Options that can be set on per-file basis are marked as such:

       -o, --option (per-file)

       These  options can be set multiple times, each subsequent instance set‐
       ting the value for the next <file> - and all the <file>s that may  fol‐
       low it if this is the last instance of setting that option.

       For example:

       ezedl --per-file-option=1 --per-file-option=2 file1.ext file2.ext file3.ext

       This  sets  --per-file-option  to  `1`  for `file1.ext`, and to `2` for
       `file2.ext` and `file3.ext`.

   Edit mode
       -e, --edit
              Enable edit mode.

       -E, --no-edit
              Disable edit mode. This is the default.

       -k, --edit-keep-temporary (per-file)
              Keep temporary files.

       -K, --edit-no-keep-temporary (per-file)
              Do not keep temporary files. This is the default.

              The temporary files are deleted right after the editor closes.

       -f, --edit-save-file[={<path>[/]|<path>/<name>.[ez]edl|<name>.[ez]edl}]
       (per-file)
              Save compiled files instead of creating temporary files. The de‐
              fault value is unset. When omitted, the value is ``.

              If <path> is not given, the EDL files are saved to  the  current
              working  directory.  If  <name>  is  not  given, the name of the
              source file with an appropriate change to the filename extension
              will be used.

              A `.edl` or `.ezedl`  extension after <name> is required because
              it serves to distinguish a directory called "<name>" from a name
              of  an  mpv  EDL  or an ezEDL file. To save to a directory whose
              name  ends   in   `.edl`   or   `.ezedl`   (without   specifying
              <name>.[ez]edl),  add  a  trailing  forward  slash  (`/`)  after
              <path>.

       -F, --edit-no-save-file (per-file)
              Do not save compiled files, but  generate  temporary  files  in‐
              stead. This is the default.

       -d, --edit-save-mkdir (per-file)
              Create the save directory (the <path> value of --edit-save-file)
              if it does not exist.

       -D, --edit-save-no-mkdir (per-file)
              Do not create the save directory (the <path>  value  of  --edit-
              save-files-* options) if it does not exist. This is the default.

       -y, --edit-save-overwrite (per-file)
              Allow overwriting existing files when saving files.

       -Y, --edit-save-no-overwrite (per-file)
              Do  not allow overwriting existing files when saving files. This
              is the default.

       -o, --edit-open-if-exists (per-file)
              Skip compiling and open the target file in the  editor  if  that
              file already exists.

              If  this option is set, -y, --edit-save-overwrite /  -Y, --edit-
              save-no-overwrite has no effect.

       -O, --edit-no-open-if-exists (per-file)
              Do not skip compiling if the target file already exists. This is
              the default.

              Further  behavior dependes on the value of -y, --edit-save-over‐
              write /  -Y, --edit-save-no-overwrite.

       -V, --editor=<value>
              Choose an editor to use in -e, --edit mode.

              <value> can be one of the following:

              auto (default)
                     Automatically choose an editor based on the values of the
                     VISUAL and EDITOR environment variables.

                     If  one of said variables is set to a supported text edi‐
                     tor (`vim` or `nvim`), then that  editor  will  be  used.
                     Otherwise, the `editor_custom` function will be used.

                     See `custom` below, and ENVIRONMENT for more information.

              vim    Use Vim as the text editor.

              nvim   Use Neovim as the text editor.

              custom Use  the `editor_custom` function to launch a custom text
                     editor.

                     The `editor_custom` function can be defined in  the  con‐
                     figuration  file. The default `editor_custom` function is
                     `function editor_custom { nano "${dest_files[@]}"; }`.

       -v, --vim-layout=<value>
              Choose an layout to use when using vim as an editor.

              <value> can be one of the following:

              simple Each generated file is opened in a separate tab.

              split (default)
                     Tabs are split into two panes, with the generated file at
                     the top, and the original file at the bottom.

              tab    Each  generated and original file is opened in a separate
                     tab.

       -h, --vim-split-height=<value>
              Adjust the height of the bottom  pane  when  using  the  `split`
              value  of -v, --vim-layout. <value> can be a positive integer or
              an empty string. The default <value> is one-third of the  avail‐
              able  screen height if the Bash variable LINES is set, otherwise
              the default value is an empty string.

   Compiling
       -t, --convert-timestamps (per-file)
              Convert timestamps from seconds to HH:MM:SS.s  format.  This  is
              the default.

              This  option  only  has  effect  when  compiling from mpv EDL to
              ezEDL.

       -T, --no-convert-timestamps (per-file)
              Do not convert timestamps from seconds to HH:MM:SS.s format.

              This option only has effect  when  compiling  from  mpv  EDL  to
              ezEDL.

       -a, --convert-length-to-end (per-file)
              Use  `end` instead of `length` as an alternative way to indicate
              the end of the segment. This is the default.

              This option only has effect  when  compiling  from  mpv  EDL  to
              ezEDL.

       -A, --no-convert-length-to-end (per-file)
              Do  not  use  `end` as an alternative way to indicate the end of
              the segment. Use mpv EDL's original `length`.

              This option only has effect  when  compiling  from  mpv  EDL  to
              ezEDL.

       -b, --include-empty-lines (per-file)
              Preserve blank lines. This is the default.

       -B, --no-include-empty-lines (per-file)
              Do not preserve blank lines.

       -c, --include-comments (per-file)
              Preserve comments. This is the default.

       -C, --no-include-comments (per-file)
              Do not preserve comments.

   Direction policy
       --direction={auto|to|from} (per-file)
              Set direction of compiling. The default value is `auto`.

              `to`  refers to compiling *to* ezEDL (mpv EDL -> ezEDL); `from`,
              to compiling *from* ezEDL (ezEDL -> mpv EDL).

              NB: Provided that the files passed  to  ezedl  have  appropriate
              filename  extensions  and  headers, there is no need to manually
              set --direction.

                        Extension   Header
              ezEDL     .ezedl      # ezEDL v0
              mpv EDL   .edl        # mpv EDL v0

              In cases where filename extensions and/or headers  are  missing,
              or  conflict  with each other, the behavior is determined by the
              values set by the rest of the --direction-* options  listed  be‐
              low.

       --direction-auto-extension-no-header={warning|error|quiet} (per-file)
              What  to do when --direction is `auto`, and a file has an exten‐
              sion, but is missing a matching header.  The  default  value  is
              `error`.

       --direction-auto-header-no-extension={warning|error|quiet} (per-file)
              What  to do when --direction is `auto`, and a file has a header,
              but is missing a matching extension. The default value is `warn‐
              ing`.

       --direction-auto-fallback={to|from} (per-file)
              Fallback  compiling  direction  for  cases when autodetection of
              compiling direction fails. The default value is `to`.

              See --direction-auto-no-header-no-extension  for  more  informa‐
              tion.

       --direction-auto-no-header-no-extension={warning[,{to|from}]|er‐
       ror|quiet[,{to|from}]} (per-file)
              What to do when --direction is `auto`, and a file has neither  a
              recognized header, nor a recognized extension. The default value
              is `error`.

              Since both the extension and the header are missing,  ezedl  has
              no  way to automatically determine --direction, and thus the au‐
              todetection of compiling direction fails.

              When this option is set to `warning` or `quiet`,  the  secondary
              comma-delimited  value  can be passed (e.g. `warning,from`) that
              determines the fallback compiling direction. If  this  secondary
              value  is  not given, the value set by --direction-auto-fallback
              is used.

       --direction-manual-extension-no-header={warning|error|quiet} (per-file)
              What to do when --direction is `to` or `from`, and a file has an
              extension,  but  is missing a matching header. The default value
              is `warning`.

       --direction-manual-header-no-extension={warning|error|quiet} (per-file)
              What to do when --direction is `to` or `from`, and a file has  a
              header,  but  is missing a matching extension. The default value
              is `warning`.

       --direction-manual-no-header-no-extension={warning|error|quiet}   (per-
       file)
              What  to  do  when --direction is `to` or `from`, and a file has
              neither a recognized header, nor a recognized extension. The de‐
              fault value is `warning`.

   Other
       --color
              Colorize the output. This is the default.

       --no-color
              Disable colorization of the output.

       --help Print help.

       --version
              Print version information.

ENVIRONMENT
   EZEDL_LIB_DIR
       ezedl  is a program that consists of multiple files. All the files that
       ezedl requires are stored in the lib  directory  located  in  the  same
       folder as the main script.

       Normally, ezedl should be able to determine its own locatiion, and thus
       the location of the lib folder. If for whatever reason ezedl is  unable
       to  determine  its  own location, or the user wishes to store ezedl li‐
       brary files elsewhere, the EZEDL_LIB_DIR enviroment variable can be set
       to manually point to a directory containing ezedl library files.

   VISUAL / EDITOR
       The  values  of  VISUAL  and EDITOR environment variables are respected
       when choosing the editor to use in -e, --edit mode if -V,  --editor  is
       set to `auto`.

       VISUAL  is  evaluated  first. If not set, then EDITOR is evaluated. See
       -V, --editor for more information.

FILES
       A configuration file can be used to set default options.

       The  configuration  file's  location   is   $XDG_CONFIG_HOME/ezedl/con‐
       fig.bash. If XDG_CONFIG_HOME is not set, it defaults to ~/.config.

AUTHOR
       Alex Rogers <https://github.com/linguisticmind>

HOMEPAGE
       <https://github.com/linguisticmind/ezedl>

COPYRIGHT
       Copyright  ©  2024  Alex  Rogers.  License GPLv3+: GNU GPL version 3 or
       later <https://gnu.org/licenses/gpl.html>.

       This is free software: you are free  to  change  and  redistribute  it.
       There is NO WARRANTY, to the extent permitted by law.

EZEDL 0.1.1                          2024                             EZEDL(1)
```

## License

[GNU General Public License v3.0](LICENSE)
