cfgdir := "${HOME}/.config"
pwd := "${PWD}"

mise:
    curl https://mise.run | sh

nvim:
    mkdir -p "{{cfgdir}}/nvim/lua/plugins"
    -fd --type file --extension lua . nvim --exec ln -vs "{{pwd}}/{}" "{{cfgdir}}/{}"

fish:
    mkdir -p "{{cfgdir}}/fish/functions"
    touch "{{cfgdir}}/fish/local.fish"
    -fd --type file --extension fish . fish --exec ln -vs "{{pwd}}/{}" "{{cfgdir}}/{}"

wezterm:
    mkdir -p "{{cfgdir}}/wezterm"
    -fd --type file --extension lua . wezterm --exec ln -vs "{{pwd}}/{}" "{{cfgdir}}/{}"

ghostty:
    mkdir -p "{{cfgdir}}/ghostty/themes"
    -fd --type file . ghostty --exec ln -vs "{{pwd}}/{}" "{{cfgdir}}/{}"


homebrew:
    mkdir -p "{{cfgdir}}/homebrew"
    -fd --type file . homebrew --exec ln -vs "{{pwd}}/{}" "{{cfgdir}}/{}"
