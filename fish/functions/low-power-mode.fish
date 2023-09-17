function low-power-mode
    switch $argv[1]
        case 'on'
            sudo pmset -b lowpowermode 1
        case 'off'
            sudo pmset -b lowpowermode 0
        case '*'
            echo 'valid values: on | off'
            echo '----'
    end
    pmset -g custom | rg --color=never '(^Battery)|(^AC)| lowpower'
end
