#!/bin/bash

status=$(systemctl is-active postgresql.service)

function run_pgadmin {
    source "$HOME/pgadmin4/bin/activate"
    cd "$HOME/pgadmin4"
    pgadmin4
}

case $1 in
-a) 
  if [ "$status" != "active" ]
    then
      sudo systemctl start postgresql.service
  fi
  run_pgadmin
  echo "done!"
;;
-c) echo "$status";;
-s)
  if [ "$status" == "active" ]
    then
      sudo systemctl stop postgresql.service
    else
      sudo systemctl start postgresql.service
      run_pgadmin
  fi
  echo "done!"
;;
*)
  echo "Unknown:
Use -a for run pgadmin
Use -c for check is-active status postgresql.service
Use -s for on/off postgresql.service"
;;
esac

