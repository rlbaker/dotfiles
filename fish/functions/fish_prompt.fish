function fish_prompt --description 'Write out the prompt'
    set -l last_status $status
    set -l normal (set_color normal)
    set -l cwd_color (set_color bryellow)
    set -l vcs_color (set_color purple)
    set -l status_color (set_color $fish_color_command)
    set -l prompt_status ''

    set -l suffix ' $'

    if test $last_status -ne 0
        set status_color (set_color red)
        set prompt_status ' ' $status_color $last_status
    end

    echo -n -s \
        $cwd_color (prompt_pwd) $normal \
        $vcs_color (fish_vcs_prompt) $normal \
        $status_color $prompt_status $normal \
        $status_color $suffix \
        "$normal "
end
