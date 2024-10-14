while [ ! -f /tmp/node-ready ]; do
    sleep 0.1
done

cp /assets/calculator/index.html .
npx --yes serve --listen http://0.0.0.0:3000

touch /tmp/bg-ready
