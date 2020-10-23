function brch
	git b | grep '*' | sed -e 's/\* //g'
end
