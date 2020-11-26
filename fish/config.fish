source /Users/rlbaker/.config/fish/colors.fish

set __fish_git_prompt_show_informative_status true
set -g -x LSCOLORS ExFxCxDxBxegedabagacad

set -g fish_term24bit 1
set fish_greeting # disable startup message
set fish_user_paths $HOME/.cargo/bin $HOME/go/bin /Applications/Postgres.app/Contents/Versions/latest/bin

# use neovim
alias vim='nvim'
set -g -x EDITOR nvim

# don't copy garbage into tar files
set -g -x COPYFILE_DISABLED 1

# homebrew config
set -g -x HOMEBREW_FORCE_BREWED_GIT 1
set -g -x HOMEBREW_BUNDLE_FILE "$HOME/.config/brew/Brewfile"
set -g -x HOMEBREW_BUNDLE_NO_LOCK true

# fzf config
set -g -x FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
set -g -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

# opam
source /Users/rlbaker/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
