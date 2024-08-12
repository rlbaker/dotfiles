function update-zig
    pushd $HOME

    mise use --force --global zig@master

    cd src/zig
    if test ! -d $HOME/src/zig/zls
        git clone https://github.com/zigtools/zls
    end

    cd zls
    git pull
    zig build -Doptimize=ReleaseSafe
    cp zig-out/bin/zls $HOME/.local/bin

    popd
end
