function myhostname --description 'Retrives computer name with domain name appended.'
	networksetup -getcomputername | sed -e "s/ /-/g" -e "s/’//g" -e "s/\$/.local/"
end
