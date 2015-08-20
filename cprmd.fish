function cprmd --description 'Creates destination folder and copies into it.'
	if not test -e $argv[1]
echo "Source item does not exist.  Exiting."
exit 1

else if test -f $argv[1]
set sub_folder (dirname $argv[1])

else if test -d $argv[1]
set sub_folder $argv[1]

else
echo "Source item is neither a file nor folder.  Exiting."
exit 2

end

if not test -e $argv[2]
echo "Target folder does not exist.  Exiting."
exit 3

else if test -f $argv[2]
echo "Target folder is a file.  Exiting."
exit 4

else if test -d $argv[2]
set dest_folder $argv[2]/$sub_folder

else
echo "Target item is not a folder.  Exiting."
exit 5

end

mkdir -p $dest_folder

cp -r $argv[1] $argv[2]/$sub_folder
end
