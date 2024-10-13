# spinner adapted from https://stackoverflow.com/a/3330834

while true; do
    for s in / - \\ \|; do
        clear
        echo "$s Loading..."
        sleep 0.1

        if [ -f /tmp/bg-ready ]; then
            break 2
        fi
    done
done

rm /tmp/bg-ready # prepare for next invocation
clear
