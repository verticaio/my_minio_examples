minio_env_name='minio_local_cluster'
bucket_names=$(mc  ls $minio_env_name/ | awk  '{print $5}' | awk -F/ '{print $1}')
bucket_limit='1' # compare with GB 
email_address='devops@kapitalbank.az'
if ! check_mc_command="$(type -p 'mc')" || [[ -z $check_mc_command ]]; then
  echo "Please install minio client command...."
  exit 1
fi

for b_name in $bucket_names
do
    bucket_empty_size_result=$(mc ls -r --json $minio_env_name | grep $b_name > /dev/null; echo $?)
    if (( $bucket_empty_size_result == '0')); then
        bucket_size_kb=$(mc ls -r --json $minio_env_name/$b_name | awk '{ FS=","; print $4 }' | awk '{ FS=":"; n+=$2 } END{ print n }')
        bucket_size_gb=$(bc  <<< "$bucket_size_kb/1024/1024/1024")
        if (( $(echo "$bucket_size_gb > $bucket_limit" |bc -l) )); then
            echo "Bucket $b_name larger than $bucket_limit , sending email ...."
            echo -e "Dear DevOps Team, \n\nBucket $b_name larger than $bucket_limit,  please keep attention...\n\nBR,\nDevOps Team" | mail -s "Minio Bucket Size Notification" -r $email_address $email_address
        fi
    fi
done



