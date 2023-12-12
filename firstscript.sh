#!/bin/bash
DOMAIN = $1
RECON_TYPE = $2
DIRECTORY = ${DOMAIN}_recon

mkdir $DIRECTORY

case $2 in 
    nmap-only)
        nmap $DOMAIN > $DIRECTORY/nmap
    ;;
    dirsearch-only)
        ./dirsearch.py -u $DOMAIN -e php --simple-report=$DIRECTORY/dirsearch
    ;;
    crt-only)
        curl "https://crt.sh/?q=$DOMAIN&output=json" -o $DIRECTORY/crt
    ;;
    whois-only)
        whois $DOMAIN
    ;;
    gobuster-only)
        gobuster dns -d $DOMAIN -w ~/wordlists/subdomains.txt -o $DIRECTORY/gobuster
    ;;
    *)
        nmap $DOMAIN > $DIRECTORY/nmap
        ./dirsearch.py -u $DOMAIN -e php --simple-report=$DIRECTORY/dirsearch
        curl "https://crt.sh/?q=$DOMAIN&output=json" -o $DIRECTORY/crt
        whois $DOMAIN
        gobuster dns -d $DOMAIN -w ~/wordlists/subdomains.txt -o $DIRECTORY/gobuster
esac
