#!/bin/bash

# Program to encrypt and store passwords in a file
clear

encrypt_password(){
    echo "Input the password to be encrypted"
    read -s password
    hex_password=$(printf '%s' "$password" | xxd -p)


    echo "Input the encryption hex number (WRITE THIS DOWN)"
    read -s key

    #hex_output=$(printf '%s' "$password" | xxd -p)

    encrypted_password=$((0x$hex_password * 0x$key))    
    #echo $encrypted_password
    printf "%x" "$encrypted_password"

    echo "$encrypted_password" >> password.txt

}

decrypt_passwords(){
    echo "Please input the decryption key to see your passwords."
    read -s key

    encrypted_passwords=$(cat password.txt)
    
    decrypted_passwords=$((0x$encrypted_passwords / 0x$key))

    printf "%x" "$decrypted_passwords"
}



echo "Password Manager
"
read -p "Would you like to encrypt or decrypt a password?[e/d]: " mode

input_loop=0

while [ input_loop != 1 ] do 

if [[ $mode == "e" || $mode == "E" ]]; then
    encrypt_password
elif [[ $mode == "d" || $mode == "D" ]]; then
    decrypt_passwords
else
    echo "not a valid answer"
fi

done