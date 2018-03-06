# Using Config Files
This document explains how to use the config files in this directory.

# TODO
- [ ] Create platform independent Shell script to install config files
- [ ] Update .gitignore template
- [ ] Add Sublime Text 3 key bindings config file
- [ ] Add Sublime Text 3 Packages config file

## Files
* .bashrc
* .vimrc
* ccs_gitignore.txt
* Default (Windows).sublime-mousemap

## Using .[bash|vim]rc Files
These config files are useful for ConEmu on Windows with Git Bash as the
default tab or calling Bash on a Terminal on Linux or Mac.

Copy the files to the home directory (using a Bash terminal):
> `cp .vimrc ~/.vimrc`
>
> `cp .bashrc ~/.bashrc`

## Using ccs_gitignore.txt
This file is a basic template showing what should be kept on your project's
.gitignore when developing. Use this template to ignore generated files that
should not be version controlled in your repo.

## Using Sublime Text 3 Config Files
This section covers adding a mousemap and keymap file for Sublime.

### Adding Mousemap File to Sublime
"Default (Windows).sublime-mousemap" is a config file that allows
(**Ctrl+Left Click**) to perform a "goto_definition" as Eclipse does. A
(**Ctrl+Right Click**) will perform a "jump_back" to return to the previous
location.

#### To install this file on Windows:
> `cp "Default (Windows).sublime-mousemap" "~/AppData/Roaming/Sublime Text 3/
Packages/User/Default (Windows).sublime-mousemap"`

#### To install this file on Linux:
> `cp "Default (Windows).sublime-mousemap" "~/.config/sublime-text-3/Packages/
User/Default (Linux).sublime-mousemap"`

#### To install this file on Mac:
> `cp "Default (Windows).sublime-mousemap" "~/Library/Application Support/
Sublime Text 3/Packages/UserDefault (OSX).sublime-mousemap"`

### Adding Keymap File to Sublime
todo

### Sublime Packages
todo
