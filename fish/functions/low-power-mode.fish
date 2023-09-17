function low-power-mode
    switch $argv[1]
        case 'on'
            sudo pmset -b lowpowermode 1
            echo 'low power mode enabled'
        case 'off'
            sudo pmset -b lowpowermode 0
            echo 'low power mode disabled'
        case '*'
            echo 'valid values: on | off'
    end
end
