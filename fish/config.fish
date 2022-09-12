set -g fish_greeting           # disable startup message

# gruvbox theme
set fish_color_normal         normal    # default color
set fish_color_command        brgreen   # commands like echo
set fish_color_keyword        normal -o # keywords like if, for
set fish_color_quote          normal    # quoted text
set fish_color_redirection    yellow    # io redirections like >/dev/null and 2>&1
set fish_color_end            brblack   # process separators like ; and &
set fish_color_error          brred     # syntax errors
set fish_color_param          normal    # ordinary command parameters
set fish_color_valid_path     brcyan    # parameters that are filenames (if the file exists)
set fish_color_option         normal    # - options, up to first --
set fish_color_comment        white -i  # comments like '# important'
set fish_color_selection      normal    # selected text in vi visual mode
set fish_color_operator       purple    # parameter expansion operators like * and ~
set fish_color_escape         purple    # character escapes like \n and \x70
set fish_color_autosuggestion brblack   # autosuggestions (the proposed rest of a command)
set fish_color_cancel         brblack   # '^C' indicator on a canceled command
set fish_color_search_match   -b yellow # background color for history search matches and selected pager items

set -g __fish_git_prompt_showupstream auto
set -g __fish_git_prompt_show_informative_status
set -g __fish_git_prompt_showcolorhints
set -g __fish_git_prompt_color purple

set -gx LSCOLORS xXfxgxdxBaahahahahahah

set -gx COPYFILE_DISABLED 1 # don't copy garbage into tar files

source $HOME/.config/fish/local.fish # load system-specific configuration

fish_add_path /Applications/Postgres.app/Contents/Versions/latest/bin
fish_add_path $HOME/.nvim-nightly/nvim-macos/bin
fish_add_path $HOME/.zig-nightly/latest
set -gx EDITOR nvim
alias vim="nvim"

# populate homebrew vars
if test (uname -p) = 'arm'
    /opt/homebrew/bin/brew shellenv | source
else
    /usr/local/bin/brew shellenv | source
end

set -gx HOMEBREW_BUNDLE_FILE $HOME/.config/homebrew/Brewfile
set -gx HOMEBREW_FORCE_BREWED_GIT 1
set -gx HOMEBREW_BUNDLE_NO_LOCK 1
source $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.fish

