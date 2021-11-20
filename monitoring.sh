arc=$(uname -a)
pproc=$(cat /proc/cpuinfo | grep "physical id" | wc -l)
#pproc=$(nproc --all)
vproc=$(cat /proc/cpuinfo | grep processor | wc -l)
ram_used=$(free -m | awk '$1 == "Mem:" {printf "%d", $3}')
ram_total=$(free -m | awk '$1 == "Mem:" {printf "%dMB", $2}')
ram_rate=$(free -m | awk '$1 == "Mem:" {printf "%.2f", ($3/$2)*100}')
disk_used=$(df -Bm | grep /dev/ | grep /boot | awk '{u+=$3} END {print u}')
disk_total=$(df -Bg | grep /dev/ | grep /boot | awk '{t+=$2} END {print t}')
disk_rate=$(df -Bm | grep /dev/ | grep /boot | awk '{t+=$2} {u+=$3} END {printf "%d", u/t*100}')
cpu_load=$(top -ibn1 | grep ^%Cpu | awk '{printf "%.1f%%", $2+$4}')
lvm_count=$(lsblk | grep lvm | wc -l)
lvm=$(if [ $lvm_count == 0 ]; then echo "no"; else echo "yes"; fi)
boot=$(who -b | awk '{printf "%s %s", $3, $4}')
tcp=$(netstat -s -t | grep "connections established" | awk '{printf "%d %s", $1, toupper($3)}')
users=$(who | wc -l)
ipv4=$(hostname -I)
mac_addr=$(ip link | grep link/ether | awk '{print $2}')
sudo_count=$(journalctl _COMM=sudo | grep COMMAND | wc -l)
wall "  #Architecture: $arc
        #CPU physical : $pproc
        #vCPU : $vproc
        #Memory Usage: $ram_used/$ram_total ($ram_rate%)
        #Disk Usage: $disk_used/${disk_total}Gb ($disk_rate%)
        #CPU load: $cpu_load
        #Last boot: $boot
        #LVM use: $lvm
        #Connexions TCP : $tcp
        #User log: $users"