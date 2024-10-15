cd ~/workspace

[ "$(cat /tmp/before.stamp)" -ne "$(stat -c %X st.out)" ]
