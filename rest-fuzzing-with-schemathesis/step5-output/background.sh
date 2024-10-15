cd ~/workspace

cp /assets/st.out ~/workspace/ # for determinism, so we can explain it properly
stat -c %X ~/workspace/st.out > /tmp/before.stamp

touch /tmp/bg-ready
