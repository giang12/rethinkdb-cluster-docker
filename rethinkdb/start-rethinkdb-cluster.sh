#!/bin/bash -e

IFS=';'; dbHostsArray=($JOIN); unset IFS;
joinString=" "

for dbHost in ${dbHostsArray[*]}
do
  hostExists=`getent hosts $dbHost`

  if [ ! -z "$hostExists" ]
  then
    joinString="$joinString --join $dbHost"
  fi
done

cmd="$@"
if [ ${#cmd} -ge 1 ]; then
	exec "$@"
else
	canonical_address=$(hostname -i)

	echo "canonical_address: ${canonical_address}"

	run_cmd="/usr/bin/rethinkdb --bind all"
	run_cmd="${run_cmd} -d /data"
	arr_canonical_address=(${canonical_address})
	for addr in "${arr_canonical_address[@]}"; do
		run_cmd="${run_cmd} --canonical-address ${addr}:29015"
	done

	# if [ -n "$JOIN" ]; then
	# 	join_resolved=$(eval "getent hosts ${JOIN}" | awk '{ print $1}')
	# 	echo "join_resolved: ${join_resolved}"
	# 	# ensure that we're not trying to join ourselves
	# 	resolved_result=""
	# 	for i in $join_resolved; do
	# 		for addr in "${arr_canonical_address[@]}"; do
	# 			if [ $i != $addr ]; then
	# 				resolved_result="${resolved_result} ${i}"
	# 			fi
	# 		done
	# 	done
	# 	# ensure we're only trying to join a single IP
	# 	resolved_result=$(echo "$resolved_result" | awk '{ print $1 }')
	# 	echo "resolved_result: ${resolved_result}"
	# 	# only add join part of command if another IP remaining
	# 	if [ -n "$resolved_result" ]; then
	# 		run_cmd="${run_cmd} -j ${resolved_result}:29015"
	# 	fi
	# fi
	echo "Running command: ${run_cmd}"
	exec $run_cmd $joinString $RETHINKARGS
fi



