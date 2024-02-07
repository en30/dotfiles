all: symlink homebrew asdf go zsh
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
	@git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0

go:
	@git config --global ghq.root ~/src

zsh:
	@echo "Installing oh-my-zsh ..."
	@curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
	@mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc

