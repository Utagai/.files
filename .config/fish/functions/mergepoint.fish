function mergepoint
	git merge-base (git rev-parse --abbrev-ref HEAD) master
end
