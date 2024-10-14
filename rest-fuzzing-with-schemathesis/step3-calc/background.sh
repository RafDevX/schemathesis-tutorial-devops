while [ ! -f /tmp/node-ready ]; do
    sleep 0.1
done

cp /assets/calculator/index.html .
python3 -m http.server 3000 &

touch /tmp/bg-ready
