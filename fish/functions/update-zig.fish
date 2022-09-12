function update-zig
    mkdir -p ~/.zig-nightly
    pushd ~/.zig-nightly

    set platform 'x86_64'
    if test (uname -a) = 'arm'
        set platform 'aarch64'
    end
    
    curl -LO 'https://ziglang.org/download/index.json'

    set zig_version (jq --raw-output '.master.version' index.json)
    set zig_url (jq --raw-output ".master | .[\"$platform-macos\"] | .tarball" index.json)

    rm -rf ./latest
    mkdir ./latest
    curl -L $zig_url | tar x -C ./latest/ --strip-components=1

    popd
end
