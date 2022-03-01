source $HOME/.config/fish/colors.fish

set fish_greeting # disable startup message

set -g fish_term24bit 1 # force truecolor

# set __fish_git_prompt_show_informative_status true
set -gx LSCOLORS ExFxCxDxBxegedabagacad

set -gx fish_user_paths $HOME/.go/bin $HOME/.nvim-nightly/nvim-osx64/bin /Applications/Postgres.app/Contents/Versions/latest/bin

alias vim="nvim"
set -gx EDITOR nvim

# don't copy garbage into tar files
set -gx COPYFILE_DISABLED 1

# homebrew config
set -gx HOMEBREW_FORCE_BREWED_GIT 1
set -gx HOMEBREW_BUNDLE_NO_LOCK true
set -gx HOMEBREW_BUNDLE_FILE "$HOME/.config/brew/Brewfile"

set -gx GOPATH "$HOME/.go"

fish_add_path /usr/local/opt/curl/bin

source /usr/local/opt/asdf/libexec/asdf.fish

# per-system config
source $HOME/.config/fish/local.fish

if status is-interactive
and not set -q TMUX
    tmux new-session -A -s 0
end

