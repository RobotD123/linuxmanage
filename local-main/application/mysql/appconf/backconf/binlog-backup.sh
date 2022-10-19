#!/bin/bash
### /usr/local/bin/binlog_backup.sh

###### 备份目录 ######
bak_dir="/backup/mysql"
bak_binlog_dir="${bak_dir}/daily"
bak_dump_dir="${bak_dir}/weekly"
bak_log_file="${bak_dir}/bak.log"

##### 源目录 ########
binlog_dir="/var/log/mysql/binlog/"
binlog_file="/var/log/mysql/binlog/mysql-bin.index"

####### 备份配置 ##########
date_start=`date +'%Y%m%d-%H:%M:%S'`

## 每日flushlog产生新binlog文件
/usr/bin/mysqladmin -uroot -pUser@123! flush-logs

date_end=`date +'%Y%m%d-%H:%M:%S'`
echo "starting binlog backup mysql ${db_name} at ${date_start}, ends at ${date_end} SUCC"  >> ${bak_log_file}

####### 移除7天以上的binlog******
find ${bak_binlog_dir} -mtime +7 -type f -name "mysq-bin.00000*" | xargs rm -f
