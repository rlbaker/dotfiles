function aider
    # Check if the current directory is the home directory
    if test (pwd) = "$HOME"
        echo "Error: Running aider in the home directory is not allowed." >&2
        return 1
    end

    set -l config_file "$HOME/.config/aider/aider.conf.yml"

    # Execute the aider command with the specified config file and pass through all other arguments
    command aider --config "$config_file" $argv
end
