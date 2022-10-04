#!/usr/bin/env bash
echo "Userdata using Terraform"

pubkey=""
useradd -m -s /bin/bash ${local_user} 
mkdir /home/${local_user}/.ssh
echo $pubkey > /home/${local_user}/.ssh/authorized_keys 

chmod 700 /home/${local_user}/.ssh
chmod 644 /home/${local_user}/.ssh/authorized_keys
chown -R ${local_user}:${local_user} /home/${local_user}/
