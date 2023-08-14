#!/bin/bash

mapping_file="/etc/guacamole/user-mapping.xml" 

if [ $# -lt 2 ]; then
  echo "Usage: $0 (add|delete|edit) <connection_name> [parameters]"
  exit 1
fi  

action=$1
name=$2
params=$3

if [ "$action" != "add" ] && [ "$action" != "delete" ] && [ "$action" != "edit" ]; then
  echo "Invalid action: $action"
  exit 1
fi

if [ "$action" = "add" ] && [ -z "$params" ]; then
  echo "Missing parameters for add connection"
  exit 1  
fi

if [ "$action" = "add" ]; then

  # Add connection
  sed -i "/<user-mapping>/a \<connection name=\"$name\"\>${params}\</connection\>" $mapping_file

elif [ "$action" = "delete" ]; then

  # Delete connection
  sed -i "/<connection name=\"$name\"/,+1d" $mapping_file

elif [ "$action" = "edit" ]; then

  # Edit connection
  sed -i "/<connection name=\"$name\"/,/<\/connection>/c \<connection name=\"$name\"\>${params}\</connection\>" $mapping_file

fi

echo "Guacamole user-mapping updated"
