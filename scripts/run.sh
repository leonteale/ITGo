#!/usr/bin/bash
script_out="/Secure/Tools/ITGo/public/script_output"

##Uptime:
/usr/bin/uptime -p > $script_out/uptime.txt
##up 11 hours, 36 minutes
#
#
# List local interfaces and IP:
#
for i in $(ifconfig | awk {'print $1'} | grep ":" | cut -d : -f 1 | grep -vE 'lo'); do echo $i;  ifconfig | grep -a1 $i| grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | head -1; echo""; done > $script_out/interfaces.txt
#
# docker0
# 172.17.0.1
#
# eth0
# 192.168.83.129
#
# ham0
# 25.1.90.200
#
# Active remote sessions:
#
who | grep "pts" | wc -l > $script_out/active_sessions_count.txt
#
# 1
#
who | grep "pts" > $script_out/connected_users.txt
#
# root     pts/5        2019-11-21 19:20 (10.0.0.17)
#
# Show VPN status
#
hamachi | grep status > $script_out/vpn_status.txt
#
#   status     : logged in
#
# Internet access status:
#
if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then  echo "The network is up" ;else echo "The network is down"; fi > $script_out/internet_access_status.txt
#
#
# The network is up
#
#
#
# Check the nameservers
cat /etc/resolv.conf | grep nameserver > $script_out/resolv.txt
#
#
#


