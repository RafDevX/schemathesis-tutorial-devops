cd ~/workspace

cp /assets/calculator/openapi.yaml .
stat -c %X openapi.yaml > /tmp/before.stamp

touch /tmp/bg-ready

sudo apt install -y nodejs npm
npm install --global yarn nodemon

touch /tmp/node-ready
