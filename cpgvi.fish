function cpgvi --description 'Copy and than visually edit a file.'
	cp $argv
	gvi $argv[-1]
end
