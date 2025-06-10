
while true; do
	mem_used="$(free -h --si | grep Mem | awk '{print($3)}' | sed 's/.$//')"
	mem_total="$(free -h --si | grep Mem | awk '{print($2)}' | sed 's/.$//')"
	echo "${mem_used}/${mem_total}"
	sleep 1
done
