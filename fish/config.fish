set -g fish_greeting           # disable startup message

set -g __fish_git_prompt_color brpurple
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_showcolorhints 1
set -g __fish_git_prompt_showuntrackedfiles 1
set -g __fish_git_prompt_showupstream auto

set -gx COPYFILE_DISABLED 1 # don't copy garbage into tar files
set -gx DO_NOT_TRACK 1

set -gx HOMEBREW_BUNDLE_FILE $HOME/.config/homebrew/Brewfile
set -gx HOMEBREW_BUNDLE_NO_LOCK 1
set -gx HOMEBREW_FORCE_BREWED_GIT 1
set -gx HOMEBREW_PREFIX "/opt/homebrew"
set -gx HOMEBREW_CELLAR "/opt/homebrew/Cellar"
set -gx HOMEBREW_REPOSITORY "/opt/homebrew"

set -gx GOPATH $HOME/.local/share/go
set -gx GOMODCACHE $HOME/.local/share/go/pkg/mod
set -gx GOCACHE $HOME/.cache/go-cache

set -gx EDITOR nvim

# ! set -q MANPATH; and set MANPATH ''; set -gx MANPATH "/opt/homebrew/share/man" $MANPATH;
# ! set -q INFOPATH; and set INFOPATH ''; set -gx INFOPATH "/opt/homebrew/share/info" $INFOPATH;
fish_add_path -g $HOMEBREW_PREFIX/bin $HOMEBREW_PREFIX/sbin
fish_add_path -g $HOME/.bun/bin
fish_add_path -g ~/.local/bin

if status is-interactive
    mise activate fish | source
else
    mise activate fish --shims | source
end

source $HOME/.config/fish/local.fish # load system-specific configuration

alias aider='aider --config "$HOME/.config/aider/aider.conf.yml" --model-settings-file "$HOME/.config/aider/aider.model.settings.yml"'
alias vim="nvim"
alias ccusage="bunx --bun ccusage"
alias claude="bunx --bun @anthropic-ai/claude-code"
