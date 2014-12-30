function cpvi --description 'Copy and than edit a file.'
	cp $argv
	vi $argv[-1]
end
