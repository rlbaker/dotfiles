function update-ollama
    pushd $HOME/src/llm/ollama

    git pull
    and go generate -x -v ./...
    and go install -v -trimpath .
end
