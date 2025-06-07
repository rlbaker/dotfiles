.PHONY: mise nvim fish ghostty homebrew zed

cfgdir := $(HOME)/.config

mise:
	@echo "==> Setting up mise..."
	curl https://mise.run | sh

nvim:
	@echo "==> Setting up nvim configuration..."
	mkdir -p "$(cfgdir)/nvim/lua/plugins"
	-fd --type file --extension lua . nvim --exec ln -vfs "$(CURDIR)/{}" "$(cfgdir)/{}"
	@echo "Nvim setup complete."

fish:
	@echo "==> Setting up fish configuration..."
	mkdir -p "$(cfgdir)/fish/functions"
	mkdir -p "$(cfgdir)/fish/themes"
	touch "$(cfgdir)/fish/local.fish"
	# -fd --type file --extension fish . fish --exec ln -vfs "$(CURDIR)/{}" "$(cfgdir)/{}"
	-fd --type file --extension fish --extension theme . fish --exec ln -vfs "$(CURDIR)/{}" "$(cfgdir)/{}"
	@echo "Fish setup complete."

ghostty:
	@echo "==> Setting up ghostty configuration..."
	mkdir -p "$(cfgdir)/ghostty/themes"
	-fd . ghostty --exec ln -vfs "$(CURDIR)/{}" "$(cfgdir)/{}"
	@echo "Ghostty setup complete."

homebrew:
	@echo "==> Setting up homebrew configuration..."
	mkdir -p "$(cfgdir)/homebrew"
	-fd . homebrew --exec ln -vfs "$(CURDIR)/{}" "$(cfgdir)/{}"
	@echo "Homebrew setup complete."

zed:
	@echo "==> Setting up zed configuration..."
	mkdir -p "$(cfgdir)/zed"
	-fd . zed --exec ln -vfs "$(CURDIR)/{}" "$(cfgdir)/{}"
	@echo "Zed setup complete"

