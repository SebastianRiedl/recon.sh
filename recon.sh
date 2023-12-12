#!/bin/bash
printBanner() {
	printf "\n\033[1;32m"
	printf "\t██▀███  ▓█████  ▄████▄   ▒█████   ███▄    █ \n"
	printf "\t▓██ ▒ ██▒▓█   ▀ ▒██▀ ▀█  ▒██▒  ██▒ ██ ▀█   █\n" 
	printf "\t▓██ ░▄█ ▒▒███   ▒▓█    ▄ ▒██░  ██▒▓██  ▀█ ██▒\n"
	printf "\t▒██▀▀█▄  ▒▓█  ▄ ▒▓▓▄ ▄██▒▒██   ██░▓██▒  ▐▌██▒\n"
	printf "\t░██▓ ▒██▒░▒████▒▒ ▓███▀ ░░ ████▓▒░▒██░   ▓██░\n"
	printf "\t░ ▒▓ ░▒▓░░░ ▒░ ░░ ░▒ ▒  ░░ ▒░▒░▒░ ░ ▒░   ▒ ▒ \n"
	printf "\t░▒ ░ ▒░ ░ ░  ░  ░  ▒     ░ ▒ ▒░ ░ ░░   ░ ▒░\n"
	printf "\t░░   ░    ░   ░        ░ ░ ░ ▒     ░   ░ ░ \n"
	printf "\t░        ░  ░░ ░          ░ ░           ░ \n"
	printf "\t░\n"                                                             
	printf "\t\t Crafted with by SebastianRiedl \033[33mv1.0\n\n"	
	printf "\033[m\n"
}

show_help() {
	echo "\e[94mThis is how it works: \e[95m./recon.sh \e[91m-d [Target Domain] \e[92m-T [Scan Type] \e[96m-D [Directory]\e[0m"
	echo "\n\t-d  | (required) : Your \033[1;35mtarget\033[m"
	echo "\t-D  | (required) : Path to your \033[1;36mDirectory\033[m"
	echo "\t-T  | (optional) : Scan Type. \e[91m[nmap, dirsearch, crt.sh, ..., fullscan]\e[0m"
	
}
printBanner
show_help


while getopts d:T:D: flag
do
    case "${flag}" in
        d) DOMAIN=${OPTARG};;
        T) SCANTYPE=${OPTARG};;
        D) DIRECTORY=${OPTARG};;
    esac
done

mkdir ${DIRECTORY}_recon

nmap_scan()
{
	clear
	# progress bar?
	echo "Starting Nmap Scan..."
	echo "Results will be stored at ${DIRECTORY}_recon/nmap"
	nmap $DOMAIN > ${DIRECTORY}_recon/nmap
}

crt_scan()
{
	curl "https://crt.sh/?q=$DOMAIN&output=json" -o $DIRECTORY/crt
}

dirsearch_scan()
{
	./dirsearch.py -u $DOMAIN -e php --simple-report=$DIRECTORY/dirsearch
}

case $SCANTYPE in
		nmap_only)
			nmap_scan
		;;
		crt_only)
			crt_scan
		;;
		dirsearch_only)
			dirsearch_scan
		;;
		*)
			nmap_scan
			crt_scan
			dirsearch_scan
	esac 




