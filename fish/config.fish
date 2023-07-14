set -g fish_greeting           # disable startup message

source $HOME/.config/fish/colors.fish
set -gx LSCOLORS xXfxgxdxBaahahahahahah

source $HOME/.config/fish/local.fish # load system-specific configuration

set -gx COPYFILE_DISABLED 1 # don't copy garbage into tar files
set -gx HOMEBREW_BUNDLE_FILE $HOME/.config/homebrew/Brewfile
set -gx HOMEBREW_BUNDLE_NO_LOCK 1
set -gx HOMEBREW_FORCE_BREWED_GIT 1
/opt/homebrew/bin/brew shellenv | source

source ~/.asdf/asdf.fish
fish_add_path ~/.local/bin
fish_add_path ~/src/zig/zls/zig-out/bin

alias vim="nvim"
set -gx EDITOR nvim

