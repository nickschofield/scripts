#!/bin/bash -x
set -e

#Nick Schofield 11-11-2014

#Usage: ./deploy.sh <folder_containing_script> <host>
#e.g. ./deploy.sh RTL_5_3_0_D124 0001-db-prod-ndc

#variables
SCRIPT_PATH="/var/rundeck/projects/RTL-Deployment/rtl-update-scripts"
RTL_DIR=$SCRIPT_PATH/$1
INCR=1

function errors(){					#Check for errors in log
  ERROR="$(grep ERROR $FILE.log | wc -l)"
    if [ $ERROR -gt 0 ]; then
	  ERROR_LOG="$(grep ERROR $FILE.log | sed -e 's/^[ \t]*//')"
	  echo "Error in script... exiting script. Contact author. Error= '$ERROR_LOG'"
	  exit 1
	else
	  echo "No error in log"
	fi
}

function increment(){				#increment counters
	NUMBER_OF_FILES=$((NUMBER_OF_FILES - 1))
	INCR=$((INCR + 1))
}

#MAIN

cd $RTL_DIR
if [ $NUMBER_OF_FILES -ne 0 ]; then
	FILE=`ls | grep ^0$INCR.*pgs$`
    do /usr/bin/pgScript -h $2 -d process_activity -U postgres -e ansi $FILE 2>&1 | tee $FILE.log
    sleep 5
	  errors
	  increment
fi