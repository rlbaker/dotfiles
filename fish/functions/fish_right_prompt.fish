function fish_right_prompt
    set -l last_pipestatus $pipestatus
    set -l sep_color (set_color $gb_orange)
    set -l status_color (set_color $fish_color_status)
    echo -s -n (fish_git_prompt)
end