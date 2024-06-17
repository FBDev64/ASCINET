#!/bin/bash

find . -name "*.sh" -execdir chmod +x {} +

while true; do
	usr_type=$(gum input --placeholder="[A]dmin, [C]lient, or [S]erver ?")
	error_num=0

	if [ $usr_type == "A" ]; then
		./src/admin.sh
	elif [ $usr_type == "C" ]; then
		./src/client.sh
	elif [ $usr_type == "S" ]; then
		./src/server/server.sh
	else
		gum log --level error "Enter A, C or S."
		error_num = error_num + 1
	fi
done
