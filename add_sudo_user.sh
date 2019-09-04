#!/bin/bash

user_list=(
 'user1'
 'user2'
)


PASSWORD='yourpassword'
for user in ${user_list[*]}
do
    id -u ${user} &> /dev/null
    if [ $? -eq 0 ]; then
        echo -e "${user} User already exists"
    else
        adduser ${user}
        if [ $? -eq 0 ]; then
        echo "Add ${user} successful"
        fi

        echo ${PASSWORD} | passwd --stdin ${user}
        if [ $? -eq 0 ]; then
            echo "${user} Initialize the password successfully" 
            echo "${user} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
            echo "add sudo successful!"
        fi
    fi
done
