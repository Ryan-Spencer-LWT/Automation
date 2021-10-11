#!/bin/bash
read -p "Enter Your IAM User Name: " IAM_User_Name

user_cnt=`aws iam list-users | grep -w "${IAM_User_Name}" | grep -v grep | wc -l`

if [ ${user_cnt} == 0 ]
then
        echo "${IAM_User_Name} is not a valid IAM User"
        echo "Please try again with a valid IAM User"
        exit 1
fi
aws iam list-groups-for-user --user-name ${IAM_User_Name} | awk -F group/ '{print $2}' ORS=" "

