function update-go-tools
    set tools \
        'golang.org/x/tools/gopls@latest' \
        'golang.org/x/tools/cmd/deadcode@latest' \
        'github.com/fatih/gomodifytags@latest' \
        'github.com/josharian/impl@latest'

    for tool in $tools
        go install -v $tool
    end
end
