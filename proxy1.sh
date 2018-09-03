#!/bin/bash
clear
rm tmpproxy.list 2> /dev/null
printf "Getting Proxy.."
proxy=$(curl "http://www.freeproxylists.net/" -s | grep -Po '(?<=<tr><td>)[^<]*|(?<=</td><td>)[^<]*' | sed 's/[^0-9.]*//g' | sed '/^\s*$/d' | awk 'ORS=NR%2?FS:RS' | tr " " ":" >> tmpproxy.list)
if [[ -f "tmpproxy.list" ]] ; then
printf "Done\n"
printf "Getting Live Proxy..\n"
else
    printf "Failed\n"
    exit
fi
getproxylive(){
rm source 2> /dev/null
getcode=$(curl -X POST -s -d "list=$proxys&submit=Check" "www.proxy-checker.org/result.php" | grep -Po "(?<=code=')[^']*")
getlive=$(curl -s "http://www.proxy-checker.org/checkproxy.php?proxy=$proxys&code=$getcode" | grep -Po "(?<=</td><td>)[^<]*" | sed -n 3p)
getcountry=$(curl -s "http://www.proxy-checker.org/checkproxy.php?proxy=$proxys&code=$getcode" | grep -Po "(?<=</td><td>)[^<]*" | sed -n 5p)
    if [[ $getlive == "working" ]]
        then 
            printf "$proxys : Live [$getcountry]\n"
            printf "$proxys\n" >> proxylist.txt
        else 
            printf "$proxys : Die\n"
    fi
}
sleptime=0.2
coun=1
thread=1
for proxys in $(cat tmpproxy.list)
do
formula=$(expr $coun % $thread)
	if [[ $formula == 0 && $coun > 0 ]]; then
		sleep $sleptime
	fi
getproxylive &
coun=$[$coun+1]
done
wait
