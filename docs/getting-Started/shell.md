# Shell settings

## Description
This article mentions provide suggestions to setup your Shell environment in a more effective way. 

## Shell Prompt

The default Linux prompt is not really highlighted and not informative. 

```Bash
-bash-4.2$ my_command --options
```

A colored and more descriptive prompt helps you separating different commands and their outputs and may guide you better thru the different directories and nodes. E.g.:

!!! note ""
	<span style="color:green">submit01 </span><span style="color:blue"> ~/projectA </span><span style="color:red">$ </span><span style="color:gray">my_command --options</span>


The prompt is defined in the environment variable `$PS1` and preferably been set in  `$HOME/.bash_profile`. The following lines are a first hint and can be customized:


```Bash
# for providing the name of the git branch in the prompt
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# creating a colorful prompt
Reset="$(tput sgr0)"
Black="$(tput setaf 0)"
DarkGrey="$(tput bold ; tput setaf 0)"
LightGrey="$(tput setaf 7)"
White="$(tput bold ; tput setaf 7)"
Red="$(tput setaf 1)"
LightRed="$(tput bold ; tput setaf 1)"
Green="$(tput setaf 2)"
LightGreen="$(tput bold ; tput setaf 2)"
Brown="$(tput setaf 3)"
Yellow="$(tput bold ; tput setaf 3)"
Blue="$(tput setaf 4)"
LightBlue="$(tput bold ; tput setaf 4)"
Purple="$(tput setaf 5)"
Pink="$(tput bold ; tput setaf 5)"
Cyan="$(tput setaf 6)"
LightCyan="$(tput bold ; tput setaf 6)"
export PS1="\[$Green\]\h\[$Reset\] \[$Blue\]\w $(parse_git_branch)\[$Reset\]\[$Red\]\$\[$Reset\] "

# correct issues with tab completion of variables (\ added in front of them, preventing tab completion)
shopt -s direxpand
```

Beside the colors the shown information can be customized. These could be fixed text or from the following variables:

```Bash
\d   The date, in "Weekday Month Date" format (e.g., "Tue May 26"). 
\h   The hostname, up to the first . (e.g. deckard) 
\H   The hostname. (e.g. deckard.SS64.com)
\j   The number of tasks currently managed by the shell. 
\l   The basename of the shell's terminal device name. 
\s   The name of the shell, the basename of $0 (the portion following the final slash). 
\t   The time, in 24-hour HH:MM:SS format. 
\T   The time, in 12-hour HH:MM:SS format. 
\@   The time, in 12-hour am/pm format. 
\u   The username of the current user. 
\v   The version of Bash (e.g., 2.00) 
\V   The release of Bash, version + patchlevel (e.g., 2.00.0) 
\w   The current working directory. 
\W   The basename of $PWD. 
\!   The history number of this command. 
\#   The command number of this command. 
\$   If you are not root, inserts a "$"; if you are root, you get a "#"  (root uid = 0) 
\nnn   The character whose ASCII code is the octal value nnn. 
\n   A newline. 
\r   A carriage return. 
\e   An escape character (typically a color code). 
\a   A bell character.
\\   A backslash. 
```