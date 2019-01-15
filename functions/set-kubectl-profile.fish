function set-kubectl-profile
	set -l config ~/.kube/
	if test (ls -a1 $config | grep "$argv" | wc -l) = '0'
		echo "Invalid profile name"
	else
		set -gx KUBECONFIG $config$argv
	end
end
