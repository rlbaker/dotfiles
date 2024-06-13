set -g fish_greeting           # disable startup message

source $HOME/.config/fish/colors.fish
set -gx LSCOLORS xXfxgxdxBaahahahahahah

set __fish_git_prompt_show_informative_status 1
set __fish_git_prompt_showuntrackedfiles 1

set -gx EDITOR nvim
alias vim="nvim"

set -gx COPYFILE_DISABLED 1 # don't copy garbage into tar files

set -gx HOMEBREW_BUNDLE_FILE $HOME/.config/homebrew/Brewfile
set -gx HOMEBREW_BUNDLE_NO_LOCK 1
set -gx HOMEBREW_FORCE_BREWED_GIT 1
set -gx HOMEBREW_PREFIX "/opt/homebrew"
set -gx HOMEBREW_CELLAR "/opt/homebrew/Cellar"
set -gx HOMEBREW_REPOSITORY "/opt/homebrew"

# ! set -q MANPATH; and set MANPATH ''; set -gx MANPATH "/opt/homebrew/share/man" $MANPATH;
# ! set -q INFOPATH; and set INFOPATH ''; set -gx INFOPATH "/opt/homebrew/share/info" $INFOPATH;
# set -gx MANPATH "$HOMEBREW_PREFIX/share/man" $MANPATH
# set -gx INFOPATH "$HOMEBREW_PREFIX/share/info" $INFOPATH

fish_add_path -g $HOMEBREW_PREFIX/bin $HOMEBREW_PREFIX/sbin
fish_add_path -g ~/.local/bin

# if status is-interactive
mise activate fish | source
# else
#   mise activate fish --shims | source
# end

source $HOME/.config/fish/local.fish # load system-specific configuration
