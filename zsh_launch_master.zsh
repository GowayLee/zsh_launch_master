#!/bin/zsh

alias launch='launch_master_main'

declare launch_master_lnks=''
declare launch_master_launch_list=''
declare launch_master_open_cmd=''

# init steps
if [[ -f $HOME/.launch_master/.launch_masterrc ]]; then # check if launch_master is already initialized
  while LFS= read -r line; do
		if [[ $line == \#* || $line == +([[:space:]]) ]]; then # skip comment line
			continue
		fi
    case ${line%:*} in
    	'launch_master_lnks')
				launch_master_lnks=${line##*:}
				continue
			;;
			'launch_master_launch_list')
				launch_master_launch_list=${line##*:}
				continue
			;;
			'launch_master_open_cmd')
				launch_master_open_cmd=${line##*:}
				continue
			;;
			' ')
				echo "zsh_launch_master: Empty value of item \""${line%:*}"\" in .launch_masterrc"
				continue
			;;
			*)
				echo "zsh_launch_master: Undefined item \""${line%:*}"\" in .launch_masterrc"
				continue
			;;
		esac
	done < $HOME"/.launch_master/.launch_masterrc"
else # first open, process the initialize steps
	source $(dirname $(readlink -f $0))/launch_master_init.zsh
fi

function launch_master_main() {
  if [[ $1 == "-o" || $1 == "-opts" ]]; then
	shift
	launch_master_opts $@
  else
	launch_master_launch $@
  fi
}

function launch_master_opts() {
  while (($# > 0)); do
    case '$1' in
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
      *)
        echo 'Unknown option: $1'
        exit 1
      ;;
    esac
  done
}

function launch_master_launch() {
  while (($# > 0)); do
    if [[ $1 == *"." ]]; then
      if [[ -f $launch_master_launch_list"/"$1"launch_list" ]]; then
        while LFS= read -r line; do
          launch_master_launch $line
        done < $launch_master_launch_list"/"$1"launch_list"
        shift
      else
        echo "No such launch list: "$1"launch_list"
      fi
    else
      local app_lnk=$launch_master_lnks"/"$1".lnk"
      if [[ -f $app_lnk ]]; then
        echo "Launching "$1".lnk..."
        nohup $launch_master_open_cmd $app_lnk &>/dev/null
      else
        echo "No such application: "$1".lnk"
      fi
      shift
    fi
  done
}
