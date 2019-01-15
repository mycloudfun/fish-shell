function set-aws-profile
	if test (cat ~/.aws/config | grep "\[profile $argv\]" | wc -l) = '0'
		echo "Invalid profile name"
	else
		set -gx AWS_PROFILE $argv
	end
end
