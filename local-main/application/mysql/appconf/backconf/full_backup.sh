#!/bin/bash
### /usr/local/bin/full_backup.sh


###### 备份目录 ######
bak_dir=/backup/mysql
bak_binlog_dir="${bak_dir}/daily"
bak_dump_dir="${bak_dir}/weekly"
bak_log_file="${bak_dir}/bak.log"

####### mkdir ################
mkdir -p ${bak_dir}
mkdir -p ${bak_binlog_dir}
mkdir -p ${bak_dump_dir}

##### 备份设置 ######

date_start=`date +'%Y%m%d-%H:%M:%S'`
db_name="woods"
file_name="${db_name}_${date_start}.sql"
bak_file_path="${bak_dump_dir}/${file_name}"
echo ${file_name}
echo ${bak_file_path}
gz_file_path="${bak_file_path}.gz"
echo ${gz_file_path}

mysql_user="root"
echo ${mysql_user}
mysql_passwd="User@123!"
echo ${mysql_passwd}

###### dump数据 #######
mysqldump -uroot -pUser@123! -B -F -R  -x --master-data=2 ${db_name}|gzip > ${gz_file_path}
date_end=`date +'%Y%m%d-%H:%M:%S'`
echo "starting full backup mysql ${db_name} at ${date_start}, ends at ${date_end} SUCC"  >> ${bak_log_file}

##### 删除30天前全量备份文件 #######
find ${bak_dump_dir} -mtime +30 -type f -name "*.sql.gz" | xargs rm -f

##### 删除一周内增量备份文件 #######
cd ${bak_binlog_dir}
/bin/rm -f *