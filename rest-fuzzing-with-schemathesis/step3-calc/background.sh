cp /assets/calculator/index.html .
python3 -m http.server 3000 &

while [ ! -f /tmp/node-ready ]; do
    sleep 0.1
done

cp /assets/calculator/{package.json,yarn.lock,calculator.js} .
yarn
nodemon ./calculator.js &

echo '-w "\n"' >> ~/.curlrc # auto insert newline after response

touch /tmp/bg-ready
