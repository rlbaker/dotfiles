function update-zls
    pushd ~/src/zig/zls
    git pull
    zig build -Doptimize=ReleaseSafe -Dlog_level=warn
    popd
end
