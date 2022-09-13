dotfiles = $(shell pwd)

.PHONY: fish
fish:
	@mkdir -p $$HOME/.config/fish/
	ln -s -f $(dotfiles)/fish/config.fish $$HOME/.config/fish/config.fish
	@mkdir -p $$HOME/.config/fish/functions/
	ln -s -f $(dotfiles)/fish/functions/fish_prompt.fish $$HOME/.config/fish/functions/fish_prompt.fish
	@touch $$HOME/.config/fish/local.fish

.PHONY: nvim
nvim:
	@mkdir -p $$HOME/.config/nvim/
	ln -s -f $(dotfiles)/nvim/init.lua $$HOME/.config/nvim/init.lua

.PHONY: kitty
kitty:
	@mkdir -p $$HOME/.config/kitty/
	ln -s -f $(dotfiles)/kitty/kitty.conf $$HOME/.config/kitty/kitty.conf

.PHONY: homebrew
homebrew:
	@mkdir -p $$HOME/.config/homebrew/
	ln -s -f $(dotfiles)/homebrew/Brewfile $$HOME/.config/homebrew/Brewfile
