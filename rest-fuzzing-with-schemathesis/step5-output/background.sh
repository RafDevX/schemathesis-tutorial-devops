cd ~/workspace

cp /assets/st.out . # for determinism, so we can explain it properly
stat -c %X st.out > /tmp/before.stamp

touch /tmp/bg-ready
