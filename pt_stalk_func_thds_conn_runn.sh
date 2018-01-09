#!/bin/bash
trg_plugin() {
mysqladmin -uroot -p"password" -S /data/mysql/mysql.sock extended-status |\
awk -F"|" \
"BEGIN{ count=0; }"\
'{ if ($2 ~ /Threads_connected/){Threads_connected=$3;}\
else if ($2 ~ /Threads_running/){Threads_running=$3;}\
else if ($2 ~ /Uptime / && count >= 0){\
  print Threads_connected,Threads_running;\
}}' | awk 'BEGIN{counter=0} \
{ if ($1 > 450 || $2 > 400 ) counter++ ; } END {print counter}'
}
trg_plugin

#/usr/bin/pt-stalk --function /data/scripts/bin/pt_stalk_func_thds_conn_runn.sh --threshold 0 --daemonize --cycles 3 --user=root --ask-pass --socket=/data/mysql/mysql.sock
