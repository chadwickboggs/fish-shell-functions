function cpmd --description 'Creates destination folder and copies into it.'
	set dest_folder (dirname $argv[2])/(dirname $argv[1])
	mkdir -p $dest_folder
	cp $argv[1] $dest_folder
end
