set -g fish_greeting           # disable startup message

source $HOME/.config/fish/colors.fish
set -gx LSCOLORS xXfxgxdxBaahahahahahah

source $HOME/.config/fish/local.fish # load system-specific configuration

set -gx COPYFILE_DISABLED 1 # don't copy garbage into tar files

set -gx HOMEBREW_BUNDLE_FILE $HOME/.config/homebrew/Brewfile
set -gx HOMEBREW_BUNDLE_NO_LOCK 1
set -gx HOMEBREW_FORCE_BREWED_GIT 1
set -gx HOMEBREW_PREFIX "/opt/homebrew"
set -gx HOMEBREW_CELLAR "/opt/homebrew/Cellar"
set -gx HOMEBREW_REPOSITORY "/opt/homebrew"
set -gx MANPATH "$HOMEBREW_PREFIX/share/man" $MANPATH
set -gx INFOPATH "$HOMEBREW_PREFIX/share/info" $INFOPATH

fish_add_path $HOMEBREW_PREFIX/bin $HOMEBREW_PREFIX/sbin
fish_add_path ~/.asdf/bin
fish_add_path ~/.asdf/shims
fish_add_path ~/src/zig/zls/zig-out/bin

alias vim="nvim"
set -gx EDITOR nvim

# set -l dim (set_color brblack)
# set -l normal (set_color normal)
set -gx DIRENV_LOG_FORMAT ""; # $dim"direnv: %s"$normal
