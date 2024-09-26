#!/bin/zsh

alias launch_1='launch_master_launch'
alias launch_master='launch_master_opts'

# init steps
if [[ -f ~/.launch_master ]]; then # check if launch_master is already initialized

  



declare launch_master_open_cmd=''
case $OSTYPE in
  'msys')
    launch_master_open_cmd='start'
  ;;
  'linux')
    launch_master_open_cmd='xdg-open' # depending on xdg-utils
  ;;
  'darwin')
    launch_master_open_cmd='open'
  ;;
  *)
    echo "Launch Master:\n\tWarning: Unsupport OS \""$OSTYPE"\"\n\tLaunch Master is unable to launch applications"
    return 1
  ;;
esac

function launch_master_opts() {
  while (($# > 0)); do
    case '$1' in
      '--launch') # launch applications
        echo 'Option -a with value $2'
        shift 2
      ;;
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

function launch_master_launch() { # launch applications
  while (($# > 0)); do
    local app_lnk="./links/"$1".lnk"
    if [[ -f $app_lnk ]]; then
      echo "Launching "$1".lnk..."
      nohup $launch_master_open_cmd $app_lnk &>/dev/null
    else
      echo "No such application: "$1".lnk"
    fi
    shift
  done
}



