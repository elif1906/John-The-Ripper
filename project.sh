#!/bin/bash

function Title {
    echo
    echo -e "\e[1;31m███████    █████╗     ████╗   ███████\e[0m"
    echo -e "\e[1;31m██║       ██╔╝ ██╔══██╗   ██  ██╗    \e[0m"
    echo -e "\e[1;31m█████     ██   ██   ████████║ ██     \e[0m"
    echo -e "\e[1;31m██        ██╗  ██╔══██║   ██║╚██╗    \e[0m"
    echo -e "\e[1;31m███████║  ██║  ██   ██║   ██║ ███████   \e[0m"
    echo -e "\e[1;31m╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝   \e[0m"
    echo
    echo "_____________________________________________________"
    echo "︻デ═一Created by: Elif Nur Aslıhan Celepoğlu︻デ═一 "
    echo "-----------------------------------------------------"
}

# Check if John the Ripper is installed
if command -v john &>/dev/null; then
    echo "John the Ripper is already installed."
else
    echo "John the Ripper is not installed. Installing..."
    sudo apt-get install john -y
fi

# Go to John-The-Ripper-main directory
cd John-The-Ripper-main

while true; do
    Title
    echo "1. MD5 cracking"
    echo "2. MD4 cracking"
    echo "3. SHA-1 cracking"
    echo "4. SHA-256 cracking"
    echo "5. SHA-512 cracking"
    echo "6. Zip-file cracking"
    echo "7. Exit"

    read -p "Choose an option: " opc

    case $opc in
    1 | 2 | 3 | 4 | 5)
        read -p "Enter the hash file name: " hash_file
        read -p "Enter the wordlist file name: " wordlist

        if [ -f "$hash_file" ]; then
            if [ -f "$wordlist" ]; then
                case $opc in
                1)
                    time john --format=raw-md5 --wordlist=rockyou-10.txt md5.txt 2>&1 
                    sudo john --show --format=raw-md5 "$hash_file" 
                   
                    
                    ;;
                2)
                    time john --format=raw-md4 --wordlist="$wordlist" "$hash_file"
                    sudo john --show --format=raw-md4 "$hash_file"
                    ;;
                3)
                    time john --format=raw-sha1 --wordlist="$wordlist" "$hash_file"
                    sudo john --show --format=raw-sha1 "$hash_file"
                    ;;
                4)
                    time john --format=raw-sha256 --wordlist="$wordlist" "$hash_file"
                    sudo john --show --format=raw-sha256 "$hash_file"
                    ;;
                5)
                    time john --format=raw-sha512 --wordlist="$wordlist" "$hash_file"
                    sudo john --show --format=raw-sha512 "$hash_file"
                    ;;
                esac
            else
                echo "Wordlist not found: $wordlist"
            fi
        else
            echo "File not found: $hash_file"
        fi
        ;;
    6)
        
        read -p "Enter the zip file name: " zip_file
        
        if [ -f "$zip_file" ]; then
                touch hash.txt
		zip2john "$zip_file" > hash.txt
		cat hash.txt
		time john hash.txt
		sudo john --show hash.txt
		rm hash.txt
	else
		echo "File not found: $zip_file"
	fi
        ;;

    7)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo "Invalid option! Please try again."
        ;;
    esac
done
