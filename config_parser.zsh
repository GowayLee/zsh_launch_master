#!/bin/zsh

function LAUNCH_MASTER_FUNC_parse_config() {
	local config_file=$1
	local key=''
	local value=''
	
	if [[ ! -f $config_file ]]; then
		echo "zsh_launch_master: Cannot find config file: "$config_file" !"
		return 1
	fi

	while IFS='=' read -r key value; do
		if [[ -z $key || $key == \#* ]]; then
			continue
		fi

		# TODO: Remove spaces

		LM_VAR["${key//./_}"]=$value
	done < $config_file
}

$LM_FUNC'_parse_config' $1 $2