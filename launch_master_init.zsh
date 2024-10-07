#!/bin/zsh

declare output=''
declare cmd_status=''
declare profile=''

echo "I can't find .launch_master/ or .launch_masterrc in "$HOME", maybe it's the first time to boot zsh_launch_master.\nI will try to automatically init launch_master for you...\n"

echo "mkdir $HOME/.launch_master..."
output=$(mkdir $HOME/.launch_master 2>&1)
cmd_status=$?

if [[ $cmd_status -ne 0 ]]; then
	echo "Oh no! An error occured when I tried to create .launch_master/ in "$HOME"\n T^T Please check and rerun."
	return 1
else
	echo "Create .launch_master successfully ♪(^∇^*)\n"
fi

echo "touch $HOME/.launch_master/.launch_masterrc..."
output=$(touch $HOME/.launch_master/.launch_masterrc 2>&1)
cmd_status=$?

if [[ $cmd_status -ne 0 ]]; then
	echo "Oh no! An error occured when I tried to create .launch_master/.launch_masterrc\n T^T Please check and rerun."
	return 1
else
	echo "Create $HOME/.launch_master/.launch_masterrc successfully ♪(^∇^*)\n"
fi

profile="$HOME/.launch_master/.launch_masterrc"
echo "# >>>>>>>> The following content is auto generated by zsh_launch_master <<<<<<<<" > $profile 


echo "I'm checking your OS type..."
declare launch_master_open_cmd=''
case $OSTYPE in
  'msys')
    launch_master_open_cmd='start'
  ;;
  'linux')
    launch_master_open_cmd='xdg-open' # depending on xdg-utils
  ;;
  'darwin'|'osx')
    launch_master_open_cmd='open'
  ;;
  *)
    echo "Warning: Unsupport OS \""$OSTYPE"\"\n\tLaunch Master is unable to launch applications"
    return 1
  ;;
esac
echo "launch_master_open_cmd:"$launch_master_open_cmd"" >> $profile
echo "Your OS type: \""$OSTYPE"\", is capable for zsh_launch_master ╰(*°▽°*)╯\n"


echo "mkdir $HOME/.launch_master/launch_master_lnks..."
output=$(mkdir $HOME/.launch_master/launch_master_lnks 2>&1)
cmd_status=$?

if [[ $cmd_status -ne 0 ]]; then
	echo "Oh no! An error occured when I tried to create .launch_master/launch_master_lnks\n T^T Please check and rerun."
	return 1
else
	echo "Create $HOME/.launch_master/launch_master_lnks successfully ♪(^∇^*)\n"
fi
echo "launch_master_lnks:$HOME/.launch_master/launch_master_lnks" >> $profile


echo "mkdir $HOME/.launch_master/launch_master_launch_list..."
output=$(mkdir $HOME/.launch_master/launch_master_launch_list 2>&1)
cmd_status=$?

if [[ $cmd_status -ne 0 ]]; then
	echo "Oh no! An error occured when I tried to create .launch_master/launch_master_list\n T^T Please check and rerun."
	return 1
else
	echo "Create $HOME/.launch_master/launch_master_launch_list successfully ♪(^∇^*)\n"
fi
echo "launch_master_launch_list:$HOME/.launch_master/launch_master_launch_list" >> $profile


echo "# >>>>>>>> The content above is auto generated by zsh_launch_master <<<<<<<<" >> $profile

echo "I have successfully finished auto-config task! Now you can rerun this script.\nHave a nice day and Good-bye\n♪(￣▽￣)Bye~Bye~"

unset output
unset cmd_status
unset profile
