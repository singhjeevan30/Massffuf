#!/bin/bash
#Usage ./massffuf.sh <folder-name> <dictionary-file> <output-file>
#folder-name: name of the folder where PROBEDURLS-httprobe.txt is located.
#dictionary-file: dictionary file used for fuzzing paths.
#output-file: name of the output file.

WHITE='\033[1;37m'
GREEN="\e[92m"
RED='\033[1;31m'

display_usage() { 
		echo -e "\n${GREEN}This script must be run with super-user privileges." 
		echo -e "${WHITE}Usage:\n\n$0 <folder-name> <dictionary-file> <output-file>\n" 
		echo -e "${WHITE}folder-name:      name of the folder where PROBEDURLS-httprobe.txt is located."
		echo -e "${WHITE}dictionary-file:  dictionary file used for fuzzing paths."
		echo -e "${WHITE}output-file:      name of the output file.\n"
		}

if [[ ! -d $1 ]]
then
	if [[ $1 == '--help' || $1 == '-h' ]]
	then
		display_usage
		exit 1
	else
		echo -e "${RED}[-] Directory $1 doesn't exists!"
		display_usage
		exit 1
	fi
else
	if [[ ! -d $1/ffuf ]]
	then
		echo -e "${GREEN}[+] Creating ${WHITE}ffuf ${GREEN}directory in $1/"
		mkdir $1/ffuf
		echo -e "${GREEN}[+] Directory successfully created!"
	fi
fi

if [  $# -le 2 ] 
then 
	echo -e "${RED}[-] Invalid arguments supplied!"
	display_usage
	exit 1
fi 

if [  $# -gt 3 ] 
then 
	echo -e "${RED}[-] Invalid arguments supplied!"
	display_usage
	exit 1
fi 

if [[ $USER != "root" ]]
then 
	echo "This script must be run as root!" 
	exit 1
fi

if [[ ( $# == "--help") ||  $# == "-h" ]] 
then 
	display_usage
	exit 0
fi

echo -e "${GREEN}[+] Starting MASSFFUF!"
sleep 4

for url in $(cat $1/PROBEDURLS-httprobe.txt)
do	
ffuf -u $url/FUZZ -t 150 -mc 200,302,301,415,403 -fs 0 -w $2 | tee -a $1/ffuf/$3
done
echo -e "${GREEN}[+]StArTeD FiLtErInG.."
num=$(cat $1/ffuf/$3 | cut -d ":" -f 3 | grep Words | sed 's/\,.*//' | sort | uniq -c | sort -nr | wc -l)
for i in `seq 1 $num` 
do 
	a=$(cat $1/ffuf/$3 | cut -d ":" -f 3 | grep Words | sed 's/\,.*//' | sort | uniq -c | sort -nr | sed -n ${i}p | awk -F " " '{print $1}')
	#echo "a in iteration $i = $a"
	if [[ $a -gt 100 ]]
	then
		b=$(cat $1/ffuf/$3 | cut -d ":" -f 3 | grep Words | sed 's/\,.*//' | sort | uniq -c | sort -nr | sed -n ${i}p | awk -F " " '{print $2}')

		#echo "b in iteration $i = $b"
		if [[ $i -eq 1 ]]
		then
			cat $1/ffuf/$3 | grep -v $b, > $1/ffuf/$3.txt
		else
			grep -v $b, $1/ffuf/$3.txt > /tmp/ffuf.txt
			mv /tmp/ffuf.txt $1/ffuf/$3.txt
		fi
	else
		echo -e "${GREEN}Ending soon!"
		break
	fi
done

if [[ -f $1/ffuf/$3.txt ]]
then
rm $1/ffuf/$3
fi

sleep 4
echo -e "${GREEN}[+]DOne FiLtErInG!"
echo -e "${GREEN}[+]Results can be seen in ${WHITE}$1/ffuf/$3.txt"

