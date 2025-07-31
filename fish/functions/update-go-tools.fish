function update-go-tools
    set tools \
        'github.com/cweill/gotests/gotests@latest' \
        'github.com/fatih/gomodifytags@latest' \
        'github.com/go-delve/delve/cmd/dlv@latest' \
        'github.com/josharian/impl@latest' \
        'golang.org/x/tools/cmd/deadcode@latest' \
        'golang.org/x/tools/gopls/internal/analysis/modernize/cmd/modernize@latest' \
        'golang.org/x/tools/gopls@latest' \
        'honnef.co/go/tools/cmd/staticcheck@latest'

    for tool in $tools
        go install -v $tool
    end
end
