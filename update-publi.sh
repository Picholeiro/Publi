#!/bin/bash
for source in `cat lists.lst`; do
    echo $source;
    curl --silent $source >> ads.txt
    echo -e "\t`wc -l ads.txt | cut -d " " -f 1` lines downloaded"
done

echo -e "\nFiltering non-url content..."
perl easylist.pl ads.txt > ads_parsed.txt
rm ads.txt
echo -e "\t`wc -l ads_parsed.txt | cut -d " " -f 1` lines after parsing"

echo -e "\nRemoving duplicates..."
sort -u ads_parsed.txt > ads_unique.txt
rm ads_parsed.txt
echo -e "\t`wc -l ads_unique.txt | cut -d " " -f 1` lines after deduping"

cat ads_unique.txt >> /etc/pihole/adblock.raw
sort -u /etc/pihole/adblock.raw > /var/www/html/pihole/adblock.hosts
rm /etc/pihole/adblock.raw
#rm ads_unique.txt

#pihole -g

cat ads_unique.txt >> publi_unicos.txt
 
exit 0
