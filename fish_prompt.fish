function fish_prompt --description 'Write out the prompt'

	set -l last_status $status

	# Just calculate these once, to save a few cycles when displaying the prompt
	if not set -q __fish_prompt_hostname
		set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
	end

	if not set -q -g __fish_classic_git_functions_defined
		set -g __fish_classic_git_functions_defined
	end

	set -l delim '#'

	set -g status_prompt ''
	if test $last_status -ne 0
		set -g status_prompt " [$last_status]"
	end

	echo -s ''

	echo -n -s (set_color normal) "[" (date -u +%Y%m%d%H%M%S) "]"

	echo -n (set_color green) "$USER"

	echo -n -s (set_color normal) @ (set_color yellow) "$__fish_prompt_hostname"

	echo -n -s (set_color normal) ':' (set_color magenta) (prompt_pwd)

	echo -n -s (set_color blue) (__fish_git_prompt)

	echo -s (set_color cyan) $status_prompt (set_color normal) " $delim "

end
