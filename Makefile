all: symlink homebrew asdf go rust zsh gcloud
minimum: symlink zsh

symlink:
	@echo "Creating Symlink ..."
	@sh symlink.sh

homebrew:
	@echo "Installing homebrew ..."
	@/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	@eval "$(/opt/homebrew/bin/brew shellenv)"
	@echo "Installing libraries with homebrew ..."
	@brew bundle

asdf:
	@echo "Installing asdf ..."
	@mkdir -p ~/bin
	@curl -L https://github.com/asdf-vm/asdf/releases/download/v0.18.0/asdf-v0.18.0-darwin-arm64.tar.gz -o /tmp/asdf.tar.gz
	@echo "fe907d3af2d4600787349c01d4cbdb96  /tmp/asdf.tar.gz" | md5sum -c -
	@tar -xzf /tmp/asdf.tar.gz -C ~/bin
	@rm /tmp/asdf.tar.gz

go:
	@git config --global ghq.root ~/src

rust:
	@echo "Installing rust ..."
	@curl https://sh.rustup.rs -sSf | sh

gcloud:
	@echo "Installing gcloud ..."
	@curl -L https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-darwin-arm.tar.gz -o /tmp/google-cloud-sdk.tar.gz
	@echo "829354216486a573db79725e204f59dbfd1e6fdabcab151bff739a6aaacd7c6b  /tmp/google-cloud-sdk.tar.gz" | shasum -a 256 -c -
	@tar -xf /tmp/google-cloud-sdk.tar.gz -C ~/
	@~/google-cloud-sdk/install.sh
	@rm /tmp/google-cloud-sdk.tar.gz

zsh:
	@echo "Installing oh-my-zsh ..."
	@curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
	@mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc
