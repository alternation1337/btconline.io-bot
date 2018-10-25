#!/bin/bash
clear
printf "Insert Account ID: "; read Reff
reff(){
ran=$(shuf -i 1-20 -n 1)
pin=$(shuf -i 1000-9999 -n 1)
address=$(curl "https://www.blockchain.com/btc/unconfirmed-transactions" -s | grep -Po '(?<=<a href="/btc/address/)[^"]*' | sed -n "$ran"p)
signup=$(curl -s -X POST -d "coin_address=$address&password=$pin&action=post&refid=$Reff(https://hashmax.net/r/8997518)" --user-agent "Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:53.0) Gecko/20100101 Firefox/53.0" "https://bitminer.site/auth/register" -e "https://web.facebook.com/" -x "$proxys" -m 10 2> /dev/null)
    if [[ $signup == "" ]]
        then
   printf "[Address: $address] [Proxy: $proxys]"
            printf " [Status: Success]\n"
         else
printf "[Address: $address] [Proxy: $proxys]"
            printf " [Status: Failed]\n"
            fi
}
for proxys in $(cat proxylist.txt)
do
reff
done
