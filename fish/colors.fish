set -g gb_bg0_hard '1D2021'
set -g gb_bg0      '282828'
set -g gb_bg0_soft '32302f'
set -g gb_bg1      '3C3836'
set -g gb_bg2      '504945'
set -g gb_bg3      '665C54'
set -g gb_bg4      '7C6F64'

set -g gb_fg0_hard 'F9F5D7'
set -g gb_fg0      'FBF1C7'
set -g gb_fg0_soft 'F2E5BC'
set -g gb_fg1      'EBDBB2'
set -g gb_fg2      'D5C4A1'
set -g gb_fg3      'BDAE93'
set -g gb_fg4      'A89984'

set -g gb_gray   '928374'
set -g gb_red    'CC241D'
set -g gb_green  '98971A'
set -g gb_yellow 'D79921'
set -g gb_blue   '458588'
set -g gb_purple 'B16286'
set -g gb_aqua   '689D6A'
set -g gb_orange 'D65D0E'

set -g gb_red_bright    'FB4934'
set -g gb_green_bright  'B8BB26'
set -g gb_yellow_bright 'FABD2F'
set -g gb_blue_bright   '83A598'
set -g gb_purple_bright 'D3869B'
set -g gb_aqua_bright   '8EC07C'
set -g gb_orange_bright 'FE8019'

set -g gb_red_light    '9D0006'
set -g gb_green_light  '79740E'
set -g gb_yellow_light 'B57614'
set -g gb_blue_light   '076678'
set -g gb_purple_light '8F3F71'
set -g gb_aqua_light   '427B58'
set -g gb_orange_light 'AF3A03'

set fish_color_autosuggestion   $gb_bg4
set fish_color_cancel           $gb_bg0_hard --background=$gb_fg0
set fish_color_command          $gb_green_bright
set fish_color_comment          $gb_gray
set fish_color_cwd              $gb_yellow_bright
set fish_color_cwd_root         $gb_red
set fish_color_end              $gb_bg4
set fish_color_error            $gb_red_bright
set fish_color_escape           $gb_aqua_bright
set fish_color_history_current  $gb_green
set fish_color_host             $gb_green
set fish_color_host_remote      $gb_red
set fish_color_match            $gb_aqua_bright
set fish_color_normal           normal
set fish_color_operator         $gb_purple_bright
set fish_color_param            $gb_blue_bright
set fish_color_quote            $gb_yellow_bright
set fish_color_redirection      $gb_orange
set fish_color_search_match     --background=$gb_bg2
set fish_color_selection        $gb_bg0_hard --background=$gb_fg0_hard
set fish_color_status           $gb_red_bright
set fish_color_user             $gb_orange
set fish_color_valid_path       --underline

set fish_pager_color_completion normal
set fish_pager_color_description $gb_gray
set fish_pager_color_prefix $gb_purple_bright
set fish_pager_color_progress $gb_bg2
set fish_pager_color_selected_completion $gb_green_bright
set fish_pager_color_selected_description $gb_blue_bright

set __fish_git_prompt_color                 $gb_gray
# __fish_git_prompt_color_bare
set __fish_git_prompt_color_branch          $gb_purple
set __fish_git_prompt_color_branch_detached $gb_red
set __fish_git_prompt_color_cleanstate      $gb_green
set __fish_git_prompt_color_dirtystate      $gb_orange
# __fish_git_prompt_color_flags
set __fish_git_prompt_color_invalidstate $gb_red
# __fish_git_prompt_color_merging
# __fish_git_prompt_color_prefix
set __fish_git_prompt_color_stagedstate  $gb_blue
# __fish_git_prompt_color_stashstate
# __fish_git_prompt_color_suffix
set __fish_git_prompt_color_upstream $gb_aqua
set __fish_git_prompt_color_untrackedfiles $gb_yellow
