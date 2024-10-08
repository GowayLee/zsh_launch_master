#!/bin/zsh

declare -r LM_HOME=$(dirname $(readlink -f $0))
declare -A LM_VAR # association array for launch_master variables
declare -r LM_FUNC="LAUNCH_MASTER_FUNC" # namespace for launch_master functions

export LM_HOME
export LM_VAR
export LM_FUNC

alias launch=$LM_FUNC'_main'

# init steps
if [[ -f $HOME"/.launch_master/.launch_masterrc" ]]; then # check if launch_master is already initialized
	source $LM_HOME"/config_parser.zsh" $HOME"/.launch_master/.launch_masterrc"
else # first open, process the initialize steps
	source $LM_HOME"/auto_config.zsh" --init
fi

if [[ $? -ne 0 ]]; then
	echo "zsh_launch_master: Error in launch_master initialization."
	return 1
fi

function LAUNCH_MASTER_FUNC_main() {
  if [[ $1 == "-o" || $1 == "-opts" ]]; then
		shift
		$LM_FUNC'_opts' $@
  else
		$LM_FUNC'_launch' $@
  fi
}

function LAUNCH_MASTER_FUNC_opts() {
  while (($# > 0)); do
    case $1 in
      '-l'|'--list') # list available applications
        echo 'Option -a with value $2' 
        shift 2
      ;;
      '-s'|'--search') # search for applications
        echo 'Option -b with value $2'
        shift 2
      ;;
      '-r'|'--report') # display report 
        echo 'Option -c without value'
        shift
      ;;
      '-h'|'--help') # display help
        shift
      ;;
      '--restore-defaults')
        source $LM_HOME"/auto_config.zsh" --restore-defaults
        shift
      ;;
      *)
        echo 'Unknown option: $1'
        return 1
      ;;
    esac
  done
}

function LAUNCH_MASTER_FUNC_launch() {
  while (($# > 0)); do
    if [[ $1 == *"." ]]; then
      local list_path=${LM_VAR["dir_launch_list"]}
      if [[ -f $list_path'/'$1'launch_list' ]]; then
        while LFS= read -r line; do
          $LM_FUNC'launch' $line
        done < ${list_path}$1"launch_list"
        shift
      else
        echo "No such launch list: "$1"launch_list"
      fi
    else
      local app_lnk=${LM_VAR["dir_lnks"]}"/"$1".lnk"
      if [[ -f $app_lnk ]]; then
        echo "Launching "$1".lnk..."
        nohup ${LM_VAR["sys_open_cmd"]} $app_lnk &>/dev/null
      else
        echo "No such application: "$1".lnk"
      fi
      shift
    fi
  done
}
