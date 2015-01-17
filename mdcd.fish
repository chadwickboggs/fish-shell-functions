function mdcd --description 'Create a directory, then change into it.'
	mkdir -p $argv[1]
	cd $argv[1]
end
