while true; do
	mem_used="$(free -h --si | grep Mem | awk '{print($3)}' | sed 's/.$//')"
	if [[ $mem_used != *"."* ]] && [ ${#mem_used} -gt 2 ]; then
		mem_used="$(awk -v var="$mem_used" 'BEGIN {printf "%.1f", var/1000}')" 
	fi
	mem_total="$(free -h --si | grep Mem | awk '{print($2)}' | sed 's/.$//')"
	echo "${mem_used}/${mem_total}"
	sleep 1
done
