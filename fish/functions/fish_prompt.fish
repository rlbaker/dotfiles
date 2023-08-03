function fish_prompt --description 'Write out the prompt'
    set -l last_status $status

    set -l normal (set_color $fish_color_normal)
    set -l cwd_color (set_color $prompt_color_cwd)
    set -l status_color (set_color $prompt_color_success)

    set -l prompt_status ''
    if test $last_status -ne 0
        set status_color (set_color $prompt_color_error)
        set prompt_status ' ' $status_color $last_status
    end

    if test "$TERM_PROGRAM" = "vscode"
        echo -n -s \
            $cwd_color (prompt_pwd) $normal \
            $status_color $prompt_status $normal \
            $status_color ' $' \
            "$normal "
    else
        echo -n -s \
            $cwd_color (prompt_pwd) $normal \
            (fish_git_prompt) $normal \
            $status_color $prompt_status $normal \
            $status_color ' $' \
            "$normal "
    end
end
