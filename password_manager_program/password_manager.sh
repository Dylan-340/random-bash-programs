#!/bin/bash

# Program to encrypt and store passwords in a file
clear

encrypt_password(){
    echo "Input the password to be encrypted"
    read -s password
    hex_password=$(printf "%s" "$password" | xxd -p)

    echo "Input the encryption hex number (WRITE THIS DOWN)"
    read -s key

    echo "Please select a file to write the password to (default not saved to file)"
    read file_name

    encrypted_password=$((0x$hex_password * 0x$key))   

    #printf "%x\n" "$encrypted_password"

    if [ -z $file_name ]; then
        echo "$encrypted_password"
    else
        echo "$encrypted_password" >> $file_name
        echo "Encrypted password stored to file $file_name"
    fi
}

decrypt_passwords(){
    echo "Input the password to be decrypted"
    read password

    echo "Please input the decryption key to see your passwords."
    read -s key

    decrypted_password=$(( password / 0x$key ))
    
    hex=$(printf "%x" "$decrypted_password")
    echo "Decrypted hex value: $hex"
    echo -n "Decrypted password: "
    echo "$hex" | xxd -r -p 
    echo ""
}



echo "Password Manager (ctrl+c to exit)
"


input_loop=0

while [ input_loop != 1 ]; do

    read -p "Would you like to encrypt or decrypt a password?[e/d]: " mode

    if [[ $mode == "e" || $mode == "E" ]]; then
        encrypt_password
        input_loop=1
    elif [[ $mode == "d" || $mode == "D" ]]; then
        decrypt_passwords
        input_loop=1
    else
        echo "not a valid answer"    
    fi

done