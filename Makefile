.PHONY: fish nvim kitty homebrew demo

pwd = $(shell pwd)

fish:
	ln -vis $(pwd)/fish $$HOME/.config/fish

nvim:
	ln -vis $(pwd)/nvim $$HOME/.config/nvim

kitty:
	ln -vis $(pwd)/kitty $$HOME/.config/kitty

homebrew:
	ln -vis $(pwd)/homebrew $$HOME/.config/homebrew

demo:
	ln -vis $(pwd)/demo $$HOME/.config/demo
