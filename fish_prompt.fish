function fish_prompt --description 'Write out the prompt'

	set -l last_status $status

	# Just calculate these once, to save a few cycles when displaying the prompt
	if not set -q __fish_prompt_hostname
		set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
	end

	if not set -q __fish_prompt_normal
		set -g __fish_prompt_normal (set_color normal)
	end
	
	if not set -q -g __fish_classic_git_functions_defined
		set -g __fish_classic_git_functions_defined
	end

	set -l delim '#'

	switch $USER

	case root

		if not set -q __fish_prompt_cwd
			if set -q fish_color_cwd_root
				set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
			else
				set -g __fish_prompt_cwd (set_color $fish_color_cwd)
			end
		end

	case '*'

		if not set -q __fish_prompt_cwd
			set -g __fish_prompt_cwd (set_color $fish_color_cwd)
		end

	end

	set -g status_prompt ''
	if test $last_status -ne 0
		set -g status_prompt " [$last_status]"
	end

	#set -l now_utc (date -u +%Y%m%d%H%M)

	echo -s

	echo -n -s "[" (date -u +%Y%m%d%H%M%S) "]"

	echo -n -s " $__fish_prompt_user" (set_color green) "$USER" "$__fish_prompt_normal" 
	
	echo -n -s @ (set_color yellow) "$__fish_prompt_host" "$__fish_prompt_hostname" "$__fish_prompt_normal"
	
	echo -n -s ':' "$__fish_prompt_cwd" (set_color magenta) (prompt_pwd) "$__fish_prompt_normal"

	echo -n -s (set_color blue) (__fish_git_prompt) "$__fish_prompt_normal"

	echo -n -s (set_color cyan) "$status_prompt" "$__fish_prompt_normal"

	echo -n -s " $delim " "$__fish_prompt_normal"

end
