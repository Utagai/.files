function install_deb
	if not sudo dpkg -i $argv
    sudo apt -f install
end
end
