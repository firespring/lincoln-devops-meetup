stty -echo
set +o history
unset AWS_SESSION_TOKEN AWS_MFA_ARN AWS_SECURE_TOKEN
export AWS_ACCESS_KEY_ID=<Enter the correct value>
export AWS_SECRET_ACCESS_KEY=<Enter the correct value>
export AWS_DEFAULT_REGION=<Enter the correct value>
export AWS_ACCOUNT_ID=<Enter the correct value>
stty echo

export AWS_MFA_ARN=arn:aws:iam::${AWS_ACCOUNT_ID}:mfa/${USER} AWS_SECURE_TOKEN='' && clear && echo && read -p "Enter the MFA code for the ${USER} user on the ${AWS_ACCOUNT_ID} Account: " AWS_MFA_CODE && AWS_SECURE_TOKEN=$(aws sts get-session-token --duration-seconds 28800 --serial-number ${AWS_MFA_ARN} --token-code ${AWS_MFA_CODE}) && AWS_SECURE_TOKEN=$(echo ${AWS_SECURE_TOKEN}) && export AWS_ACCESS_KEY_ID=$(echo $AWS_SECURE_TOKEN | jq -r '.Credentials .AccessKeyId') AWS_SECRET_ACCESS_KEY=$(echo $AWS_SECURE_TOKEN | jq -r '.Credentials .SecretAccessKey') AWS_SESSION_TOKEN=$(echo $AWS_SECURE_TOKEN | jq -r '.Credentials .SessionToken') && echo && unset AWS_MFA_CODE AWS_SECURE_TOKEN AWS_MFA_ARN && set -o history || set -o history

