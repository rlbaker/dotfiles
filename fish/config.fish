# disable startup message
set fish_greeting

# force truecolor
set -g fish_term24bit 1 # force truecolor

# set colorscheme
source $HOME/.config/fish/colors.fish
set __fish_git_prompt_show_informative_status true
set -gx LSCOLORS ExFxCxDxBxegedabagacad

# setup homebrew paths
/opt/homebrew/bin/brew shellenv | source

# setup asdf paths
source /usr/local/opt/asdf/libexec/asdf.fish

# setup custom paths
fish_add_path $HOME/.nvim-nightly/nvim-osx64/bin
fish_add_path /Applications/Postgres.app/Contents/Versions/latest/bin
fish_add_path /opt/homebrew/opt/curl/bin

# Use neovim instead of vim
alias vim="nvim"
set -gx EDITOR nvim

# don't copy garbage into tar files
set -gx COPYFILE_DISABLED 1

# homebrew config
set -gx HOMEBREW_FORCE_BREWED_GIT 1
set -gx HOMEBREW_BUNDLE_NO_LOCK true

# load per-system config
source $HOME/.config/fish/local.fish

if status is-interactive
and not set -q TMUX
    tmux new-session -A -s 0
end
