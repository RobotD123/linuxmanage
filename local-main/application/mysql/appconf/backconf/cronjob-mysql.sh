#!/bin/bash
### /usr/local/bin/cronjob_mysql.sh
crontab -e

#每个星期1凌晨3:00执行完全备份脚本
0 3 * * 1 /bin/bash -x /usr/local/bin/full_backup.sh >/dev/null 2>&1
#周2-7凌晨3:00做增量备份
0 3 * * 2-7 /bin/bash -x /usr/local/bin/binlog_backup.sh >/dev/null 2>&1
