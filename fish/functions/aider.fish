function aider
    if test (pwd) = "$HOME"
        echo "Error: Running aider in the home directory is not allowed." >&2
        return 1
    end

    set -l aider_args

    set -l config_file "$HOME/.config/aider/aider.conf.yml"
    set -a aider_args --config "$config_file"

    set -l model_settings_file "$HOME/.config/aider/aider.model.settings.yml"
    if test -f "$model_settings_file"
        set -a aider_args --model-settings-file "$model_settings_file"
    end

    set -l model_metadata_file "$HOME/.config/aider/aider.model.metadata.json"
    if test -f "$model_metadata_file"
        set -a aider_args --model-metadata-file "$model_metadata_file"
    end

    command aider $aider_args $argv
end
