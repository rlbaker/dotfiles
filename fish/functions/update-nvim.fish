function update-nvim
    asdf uninstall neovim stable
    asdf install neovim stable
    asdf global neovim stable
    # asdf uninstall neovim nightly
    # asdf install neovim nightly
    # asdf global neovim nightly
end
