#!/bin/bash

# Program to encrypt and store passwords in a file
clear

encrypt_password(){
    echo "Input the password to be encrypted" # Gets the password to be encrypted
    read -s password
    hex_password=$(printf "%s" "$password" | xxd -p) # Converts the user text input to hexadecimal

    echo "Input the encryption hex number (WRITE THIS DOWN)" # Gets the hex key to encrypt the password
    read -s key

    echo "Please select a file to write the password to (default not saved to file)" # Chooses the file for the password to be written to
    read file_name

    encrypted_password=$((0x$hex_password * 0x$key)) # Multiplies the password by the key

    #printf "%x\n" "$encrypted_password"

    if [ -z $file_name ]; then # If the file name is empty the password is printed to the screen and not saved to a file
        echo "$encrypted_password"
    else
        echo "$encrypted_password" >> $file_name # Writes the password to a file of users choice
        echo "Encrypted password stored to file $file_name"
    fi
}

decrypt_passwords(){
    echo "Input the password to be decrypted" # User inputs the password echoed or saved in the file
    read password

    echo "Please input the decryption key to see your passwords." # User inputs the key used to encrypt the password
    read -s key

    decrypted_password=$(( password / 0x$key )) # Divides the password by the key to revert the encryption
    
    hex=$(printf "%x" "$decrypted_password") 
    echo "Decrypted hex value: $hex" # Shows the hex of the decrypted password
    echo -n "Decrypted password: "
    echo "$hex" | xxd -r -p # Shows the text of the decrypted password (only works if vim_common is installed)
    echo ""
}



echo "Password Manager (ctrl+c to exit)
"

while true; do

    read -p "Would you like to encrypt or decrypt a password?[e/d]: " mode

    if [[ $mode == "e" || $mode == "E" ]]; then
        encrypt_password
    elif [[ $mode == "d" || $mode == "D" ]]; then
        decrypt_passwords
    else
        echo "not a valid answer"    
    fi

done