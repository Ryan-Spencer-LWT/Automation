#!/bin/bash
///////////////////Unfinished as of now/////////////////////////
read -p "Enter the IAM User You want to Delete: " IAM_User_Name

# "This is a template Value. The completed Script would include a value list which includes all known policies"

iamuserchangepassword=arn:aws:iam::aws:policy/IAMUserChangePassword
glacierreadonly=arn:aws:iam::aws:policy/AmazonGlacierReadOnlyAccess


user_cnt=`aws iam list-users | grep -w "${IAM_User_Name}" | grep -v grep | wc -l`
if [ ${user_cnt} == 0 ]
then
        echo "${IAM_User_Name} is not a valid IAM User"
        echo "Please try again with a valid IAM User"
        exit 1
fi


userlogin_cnt=`aws iam get-login-profile --user-name ${IAM_User_Name} | grep -w ${IAM_User_Name} | grep -v grep | wc -l`
if [ ${userlogin_cnt} == 0 ]
then
        echo "${IAM_User_Name} is a valid IAM User but does not have account credentials"


userpolicy_cnt=aws iam get-policy --policy-arn ${glacierreadonly} | grep -w ${glacierreadonly} | grep -v grep | wc -l

if [ ${userpolicy_cnt} == 0 ]
then
        echo "$ This Policy is not assigned to ${IAM_User_Name}"
        echo "Please try again with a valid Policy"
        exit 1
fi



aws iam delete-login-profile --user-name ${IAM_User_Name}
aws iam detach-user-policy --policy-arn ${glacierreadonly} --user-name ${IAM_User_Name}

aws iam delete-user --user-name ${IAM_User_Name}
