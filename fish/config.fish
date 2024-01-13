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

# ! set -q MANPATH; and set MANPATH ''; set -gx MANPATH "/opt/homebrew/share/man" $MANPATH;
# ! set -q INFOPATH; and set INFOPATH ''; set -gx INFOPATH "/opt/homebrew/share/info" $INFOPATH;
# set -gx MANPATH "$HOMEBREW_PREFIX/share/man" $MANPATH
# set -gx INFOPATH "$HOMEBREW_PREFIX/share/info" $INFOPATH

set -gx ASDF_DIRENV_IGNORE_MISSING_PLUGINS 1

fish_add_path -g $HOMEBREW_PREFIX/bin $HOMEBREW_PREFIX/sbin
fish_add_path -g ~/.asdf/bin
fish_add_path -g ~/src/zig/zls/zig-out/bin
fish_add_path -g ~/.local/bin
fish_add_path -g ~/.bun/bin

alias vim="nvim"
set -gx EDITOR nvim

set -gx DIRENV_LOG_FORMAT ""
