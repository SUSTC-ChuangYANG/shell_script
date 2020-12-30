### Restrict User Access to Folder 

#### Create a new group
`$ sudo addgroup secret-group`

#### Create the chroot directory
`$ sudo mkdir /var/www/GroupFolder/`
<br>
`$ sudo chmod g+wrx /var/www/GroupFolder/`

#### Give them both to the new group
`$ sudo chgrp -R secret-group /var/www/GroupFolder/`
#### Add team members to to my group
`$ usermod -a -G secret-group chuang`
<br>
`$ usermod -a -G secret-group cai`
#### Reference
1. https://unix.stackexchange.com/questions/208960/how-to-restrict-a-user-to-one-folder-and-not-allow-them-to-move-out-his-folder
