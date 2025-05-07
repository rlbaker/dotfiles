function aider
    # Check if the current directory is the home directory
    if test (pwd) = "$HOME"
        echo "Error: Running aider in the home directory is not allowed." >&2
        return 1
    end

    set -l aider_args

    set -l config_file "$HOME/.config/aider/aider.conf.yml"
    set -a aider_args --config "$config_file"

    set -l models_file "$HOME/.config/aider/aider.model.settings.yml"
    if test -f "$models_file"
        set -a aider_args --model-settings-file "$models_file"
    end

    # Execute the aider command with the specified config file and pass through all other arguments
    command aider $aider_args --no-show-model-warnings $argv
end
