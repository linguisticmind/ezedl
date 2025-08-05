# ezedl changelog

<table>
    <tr>
        <th>Version</th>
        <th>Date</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>
            <a href='https://github.com/linguisticmind/ezedl/releases/tag/v0.1.3'>0.1.3</a>
        </td>
        <td>
            2025-08-05
        </td>
        <td>
            <p>
                Added <code>conf_dest_filename_dot</code>.
            </p>
            <p>
                Added <code>conf_edit_new_auto_create</code>.
            </p>
            <p>
                Fixed compiling not working in edit mode when edit mode is enabled by default in the configuration file.
            </p>
        </td>
    </tr>
    <tr>
        <td>
            <a href='https://github.com/linguisticmind/ezedl/releases/tag/v0.1.2'>0.1.2</a>
        </td>
        <td>
            2025-04-11
        </td>
        <td>
            <p>
                Fixed a shell quoting issue that prevented <code>vim</code> from saving a file in <code>-e, --edit</code> mode when certain special characters were present in the path (e.g. parentheses (<code>()</code>).
            </p>
            <p>
                Standardization fixes:
                <ul>
                    <li>
                        Code:
                        <ul>
                            <li>Improved the method of quoting strings for displaying them in messages. All instances of using <code>\'"${parameter//\'/\'\\\'\'}"\'</code> were replaced with <code>"${parameter@Q}"</code>.</li>
                            <li>Shifted to using a <code>script_name</code> variable set to <code>"${BASH_SOURCE##*/}"</code> to hold the name of the script shown in messages. Prior to this, <code>"${BASH_SOURCE##*/}"</code> was used directly everywhere.</li>
                            <li>Shifted to using a more semantically clear <code>==</code> comparison operator instead of <code>=</code> in conditional statements. This ensures consistency with comparison operators in other programming languages, and in <a href='https://www.gnu.org/software/bash/manual/bash.html#Shell-Arithmetic'>Bash's own arithmetic expressions</a>.</li>
                            <li>Updated the code for determining the main script's containing directory.</li>
                        </ul>
                    </li>
                </ul>
            </p>
            <p>To improve clarity, a different, separate error message is now displayed when no input file is specified as opposed to when a file does not exist or is not a file.</p>
        </td>
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
    <tr>
        <td>
            <a href='https://github.com/linguisticmind/ezedl/releases/tag/v0.1.0'>0.1.0</a>
        </td>
        <td>
            2024-04-20
        </td>
        <td>
            <p>
                Initial release.
            </p>
        </td>
    </tr>
</table>
