#!/bin/bash

mapping_file="/etc/guacamole/user-mapping.xml"

if [ $# -lt 2 ]; then
  echo "Usage: $0 (add|delete) <username> [<password>]"
  exit 1
fi

action=$1
username=$2
password=$3

if [ "$action" != "add" ] && [ "$action" != "delete" ]; then
  echo "Invalid action: $action"
  exit 1
fi

if [ "$action" = "add" ] && [ -z "$password" ]; then
  echo "Missing password for add user"
  exit 1
fi

if [ "$action" = "add" ]; then
  # Add user
  sed -i "/<user-mapping>/a \<authorize username=\"$username\" password=\"$password\"\>" $mapping_file
elif [ "$action" = "delete" ]; then 
  # Delete user
  sed -i "/<authorize username=\"$username\"/,+1d" $mapping_file
fi

echo "Guacamole user-mapping updated"
