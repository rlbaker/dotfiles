function update-zig
    mise install --force zig@master
    
    if test ! -d $HOME/src/zig/zls
        mkdir -p $HOME/src/zig
        pushd $HOME/src/zig
        git clone git@github.com:zigtools/zls.git 
        popd
    end

    pushd $HOME/src/zig/zls
    git pull
    zig build -Doptimize=ReleaseSafe
    cp ./zig-out/bin/zls $HOME/.local/bin
end
