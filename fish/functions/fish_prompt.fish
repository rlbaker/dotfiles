function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -l sep_color (set_color $gb_orange)
    set -l status_color (set_color $fish_color_status)
    set -l prompt_dir (set_color $fish_color_cwd; prompt_pwd; set_color normal)
    set -l prompt_char (set_color $gb_orange_bright; echo -n ' λ '; set_color normal)

    echo -n -s $prompt_dir \
        (fish_git_prompt) \
        (__fish_print_pipestatus " [" "]" "|" $sep_color $status_color $last_pipestatus) \
        $prompt_char
end
