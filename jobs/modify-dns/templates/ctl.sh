#!/bin/bash

JOB_NAME=modify-dns

RUN_DIR="/var/vcap/sys/run/${JOB_NAME}"
LOG_DIR="/var/vcap/sys/log/${JOB_NAME}"
PIDFILE="${RUN_DIR}/pid"

case $1 in
start)
  echo $$ > $PIDFILE
  exec iptables -t raw -A PREROUTING -p tcp -d 169.254.0.2 --dport 53 -j NOTRACK
  $SHELL
  ;;
stop)
  kill -9 `cat $PIDFILE`
  rm -f $PIDFILE
  ;;
esac

