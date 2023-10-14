function update-zig
    asdf uninstall zig master
    asdf install zig master
    asdf global zig master
end
