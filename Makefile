dotfiles = $(shell pwd)

.PHONY: fish
fish:
	mkdir -p $$HOME/.config/fish/
	-ln -s $(dotfiles)/fish/config.fish $$HOME/.config/fish/config.fish
	mkdir -p $$HOME/.config/fish/functions/
	-ln -s $(curr_dir)/fish/functions/nvim-update.fish $$HOME/.config/fish/functions/nvim-update.fish
	-ln -s $(curr_dir)/fish/functions/fish_prompt.fish $$HOME/.config/fish/functions/fish_prompt.fish

.PHONY: nvim
nvim:
	mkdir -p $$HOME/.config/nvim/
	-ln -s $(dotfiles)/nvim/init.lua $$HOME/.config/nvim/init.lua

.PHONY: kitty
kitty:
	mkdir -p $$HOME/.config/kitty/
	-ln -s $(dotfiles)/kitty/kitty.conf $$HOME/.config/kitty/kitty.conf

.PHONY: homebrew
homebrew:
	mkdir -p $$HOME/.config/homebrew/
	-ln -s $(dotfiles)/homebrew/Brewfile $$HOME/.config/homebrew/Brewfile
