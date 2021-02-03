#!/usr/bin/env bash

# Setup ssh keys and OSX keychain
# =========================================================
# - https://github.com/aaqaishtyaq/dotfiles
# - https://aaqa.dev


add_ssh_to_keychain() {
# If you're using macOS Sierra 10.12.2 or later, you will need to modify your ~/.ssh/config file to automatically load keys into the ssh-agent and store passphrases in your keychain.

    if [ -e ~/.ssh/config ]
    then
        echo "ssh config already exists. Skipping adding osx specific settings... "
    else
	    echo "Writing osx specific settings to ssh config... "
      cat <<EOT >> ~/.ssh/config
    	Host *
		    AddKeysToAgent yes
		    UseKeychain yes
		    IdentityFile ~/.ssh/id_rsa
EOT
fi
}

# SSH Keygen, Add to ssh-agent and icloud Keychain
cp ../ssh/config ~/.ssh/

echo "Generating ssh keys, adding to ssh-agent..."
read -r -p 'Input email for ssh key: ' useremail

echo "Use default ssh file location, enter a passphrase: "
ssh-keygen -t rsa -b 4096 -C "$useremail"  # will prompt for password
eval "$(ssh-agent -s)"

# Now that sshconfig is synced add key to ssh-agent and
# store passphrase in keychain
ssh-add -K ~/.ssh/id_rsa
add_ssh_to_keychain
