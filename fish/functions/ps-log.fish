function ps-log
    echo "TIME,PID,COMMAND,%CPU" > ps_log.csv
    while true
        ps -Arco pid,comm,%cpu | awk -v t=(date +%T) 'NR>1 && $3+0>0 {print t","$1","$2","$3}' >> ps_log.csv
        sleep 2.5e-1
    end
end
