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

	set -g prompt_status
	if test $last_status -ne 0
		set -g prompt_status "$__fish_prompt_status [$last_status]$__fish_prompt_normal"
	end

	set -g git_prompt (__fish_git_prompt)
	if test $git_prompt -ne 0
		set -g git_prompt (__fish_git_prompt)
	end

	set -l now_utc (date -u +%Y%m%d%H%M)

	echo
	echo -n -s "$__fish_prompt_user"
	echo -n -s "$USER" "$__fish_prompt_normal" @ "$__fish_prompt_host" "$__fish_prompt_hostname" "$__fish_prompt_normal" ':' "$__fish_prompt_cwd"
	echo -n -s (prompt_pwd) (set_color blue) "$git_prompt" (set_color cyan) "$prompt_status" "$__fish_prompt_normal"
#	echo -n -s (prompt_pwd) "$git_prompt" "$__fish_prompt_normal" '[' "$now_utc" ']' "$prompt_status"
	echo -n -s " $delim "
end
