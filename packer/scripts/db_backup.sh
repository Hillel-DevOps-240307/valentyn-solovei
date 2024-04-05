#!/bin/bash

backup_dir=/tmp/backups
logs_dir=/tmp/backup_logs
db_name=$(aws ssm get-parameter --name "MYSQL_DB" --query "Parameter.Value"  --region eu-central-1)
bucket_name=$(aws ssm get-parameter --name "BACKUP_BUCKET_NAME" --region eu-central-1 --query "Parameter.Value" --output text)


if [ ! -d "${backup_dir}" ]
then
        mkdir ${backup_dir}
        chmod 777 ${backup_dir}
fi

if [ ! -d "${logs_dir}" ]
then
        mkdir ${logs_dir}
        chmod 777 ${logs_dir}
fi


mysqldump $db_name |gzip -c > "${backup_dir}/$(hostname -s).mysql.dmp.$(date +\%Y\%m\%d\%H\%M).gz"

latest_backup=$(ls -ltr $backup_dir | tail -n 1 | awk '{print $9}')

aws s3 cp ${backup_dir}/${latest_backup} s3://$bucket_name/$latest_backup --region eu-central-1 2> ${logs_dir}/backup$(date  +\%Y\%m\%d\%H\%M).log


##removing old backups

find $backup_dir -mmin +7 -type f |xargs rm -f
#find $backup_dir -mtime +7 -type f |xargs rm -f


aws s3 ls s3://$bucket_name/ | while read -r line;
       do
       create_date=$(echo $line|awk {'print $1" "$2'})
       create_date=$(date -d"$create_date" +%s)
#        older_than=$(date --date "7 days ago" +%s)
        older_than=$(date --date "7 minute ago" +%s)
        if [[ $create_date -lt $older_than ]]
           then
            file_name=$(echo $line|awk {'print $4'})

            if [[ $file_name != "" ]]
            then
                    aws s3 rm s3://$bucket_name/$file_name
            fi
       fi

       done;
