#!/bin/zsh

function LAUNCH_MASTER_FUNC_get_input_path() {
  local input_path=''
  local prompt=''
  local var_name=''

  while (($# > 0)); do
    case "$1" in
      '-p')
        shift
        prompt="$1"
        shift
      ;;
      '-v')
        shift
        var_name="$1"
        shift
      ;;
      *)
        echo "LAUNCH_MASTER_FUNC_get_input_path: Unknown option: $1"
        return 1
      ;;
    esac
  done
  
  if [[ -n $prompt ]]; then
    echo -n "$prompt"
  fi

  while true; do
    read input_path
    if [[ -d "$input_path" ]]; then
      break
    else
      echo -n "Invalid path: "$input_path"\nPlease enter again: "
    fi
  done
  
  eval "declare -g \$var_name=\$input_path"
  return 0
}