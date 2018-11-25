#!/bin/bash

# This scriot can make any two ip/hostname in iplist free secret landing, 
# can be used in hadoop cluster configuration to achieve non-passwd login.
# Notice! To use this script, you need to install sshpass.


# write your ip_list here
ip_list=(
"server01"
"server02"
"server03"
"server04"
)
# write the username and passwd here
USERNAME='username'
PASSWORD='passwd'


result=$(hostname)  
echo "This is $result \n"
ssh-keygen -t rsa -N "" -f /home/$USERNAME/.ssh/id_rsa
if [ $? -eq 0 ]
then 
    echo "ssh generate successfully\n."
fi

for ip in ${ip_list[*]}
do
    if [ "$ip" == "$result" ]
    then 
       echo "\nskip localhost!\n"
    else
       cd 
       sshpass -p ${PASSWORD} ssh-copy-id -i .ssh/id_rsa.pub ${USERNAME}@${ip} -o StrictHostKeychecking=no &> /dev/null
       if [ $? -eq 0 ]
       then
           echo "\ndistribute to $ip successfully!\n"
       else
           echo "\nfailure!\n"
       fi
    fi
done
echo "\n\n"
