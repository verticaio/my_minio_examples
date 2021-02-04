#!/usr/bin/env bash

minio_address='http://localhost:9001'
bucket_name='bucket_name'
minio_admin_user='admin'
minio_admin_pass='pass'
minio_cluster_name='minio_object_storage'
vault_url="http://localhost:8200"
vault_skip_verify="true"
vault_token="token"
declare -a env_name=("dev" "pre" "prod" )

trap "{ mc config host remove $minio_cluster_name; unset VAULT_ADDR VAULT_SKIP_VERIFY VAULT_TOKEN; }" EXIT

echo "Add minio admin credential to enviroment"
mc config host add $minio_cluster_name  $minio_address   $minio_admin_user $minio_admin_pass && echo -e "Success\n" || exit 1

echo "Create Bucket:"
if mc mb $minio_cluster_name/$bucket_name; then
     echo -e  "Success\n"
else
     echo "Failure, exit status: $?" 
     exit 1
fi

# Generate user password for every minIO bucket user
function generate_password(){
    openssl rand -base64 16 | tr -dc '[:alnum:]\n\r'
}

# Export vault env variables
export VAULT_ADDR=$vault_url VAULT_SKIP_VERIFY=$vault_skip_verify VAULT_TOKEN=$vault_token

for env in  ${env_name[@]};
do 
    echo -e "$env enviroment:"

    echo -e "Copy sample data to bucket based on $env folder:" 
    mc cp  --recursive data/$env  $minio_cluster_name/$bucket_name

    echo -e "\nPrepare and create ${bucket_name}_${env} policy:" 
    cat ./policies/${env}.json | sed  -e "s/env_name/$env/g;s/bucket_name/$bucket_name/g" > ./policies/${bucket_name}_${env}.json && \
    mc admin policy add $minio_cluster_name  ${bucket_name}_${env}_policy  ./policies/${bucket_name}_${env}.json && rm -rf ./policies/${bucket_name}_${env}.json

    echo -e "\nCreate New User:"
    password_of_user=$(generate_password)
    mc admin user add $minio_cluster_name  ${bucket_name}_${env}_user  $password_of_user

    echo -e "\nApply  policy to user:"
    mc admin policy set $minio_cluster_name ${bucket_name}_${env}_policy  user=${bucket_name}_${env}_user

    echo -e "\nAdd user to  new group:" 
    mc admin group add $minio_cluster_name  ${bucket_name}_${env}_group ${bucket_name}_${env}_user

    echo -e "\nAdd policy to the group:"
    mc admin policy set $minio_cluster_name ${bucket_name}_${env}_policy  group=${bucket_name}_${env}_group

    echo -e "Insert bucket name, folder path, username and password to vault as credentials:"
    cat ./vault/secret.json | sed  -e "s/bucket_name_sample/$bucket_name/g;s/folder_name_sample/$env/g;s/user_sample/${bucket_name}_${env}_user/g;s/pass_sample/$password_of_user/g" > ./vault/deploysecret.json && \
    vault kv put  secret/minio/$bucket_name/$env @vault/deploysecret.json > /dev/null && rm -rf ./vault/deploysecret.json &&  \
    echo -e "Vault UI Path: secret/minio/$bucket_name/$env \n"
done