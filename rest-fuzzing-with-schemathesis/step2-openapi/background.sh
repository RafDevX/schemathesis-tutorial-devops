cd ~/workspace

cp /assets/calculator/openapi.yaml ~/workspace/openapi.yaml
stat -c %X ~/workspace/openapi.yaml > /tmp/before.stamp

touch /tmp/bg-ready

sudo apt install -y nodejs npm
npm install --global yarn nodemon

touch /tmp/node-ready
