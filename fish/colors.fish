#!/usr/bin/fish

# gruvbox theme
set fish_color_normal         normal    # default color
set fish_color_command        green   # commands like echo
set fish_color_keyword        normal -o # keywords like if, for
set fish_color_quote          normal    # quoted text
set fish_color_redirection    yellow    # io redirections like >/dev/null and 2>&1
set fish_color_end            white   # process separators like ; and &
set fish_color_error          red     # syntax errors
set fish_color_param          normal    # ordinary command parameters
set fish_color_valid_path     cyan    # parameters that are filenames (if the file exists)
set fish_color_option         normal    # - options, up to first --
set fish_color_comment        white -i  # comments like '# important'
set fish_color_selection      normal    # selected text in vi visual mode
set fish_color_operator       purple    # parameter expansion operators like * and ~
set fish_color_escape         purple    # character escapes like \n and \x70
set fish_color_autosuggestion black     # autosuggestions (the proposed rest of a command)
set fish_color_cancel         white   # '^C' indicator on a canceled command
set fish_color_search_match   -b yellow # background color for history search matches and selected pager items

set -g prompt_color_cwd bryellow
set -g prompt_color_success green
set -g prompt_color_error red

set -g __fish_git_prompt_color purple
set -g __fish_git_prompt_showupstream auto
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_showcolorhints 1
