# spinner adapted from https://stackoverflow.com/a/3330834

clear

while true; do
    for s in / - \\ \|; do
        printf "\r$s Loading..."
        sleep 0.1

        if [ -f /tmp/bg-ready ]; then
            printf "\r\e[K" # clear line
            break 2
        fi
    done
done

rm /tmp/bg-ready # prepare for next invocation
