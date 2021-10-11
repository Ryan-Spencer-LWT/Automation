#!/bin/bash

read -p "Enter a Group Name you would like to assign for the Security Auditor:" IAM_Group_Name
read -p "Enter a User Name You would like to assign for the Security Auditor:" User_Name

aws iam create-group --group-name ${IAM_Group_Name}

aws iam attach-group-policy --policy arn:aws:iam::aws:policy/SecurityAudit --group-name ${IAM_Group_Name}
aws iam create-user --user-name ${User_Name} --tags '{"Key": "Name", "Value": "Security Auditor"}'
aws iam create-login-profile \
  --user-name ${User_Name} \
  --password '3}~L=LMN]KeV3}qZ' \
  --password-reset-required

aws iam add-user-to-group --user-name ${User_Name} --group-name  ${IAM_Group_Name}
~
