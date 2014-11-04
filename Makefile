all: symlink developer-tools homebrew apps-config ruby go zsh
minimum: symlink zsh

symlink:
	@echo "Creating Symlink ..."
	@sh symlink.sh

developer-tools:
	@echo "Installing Commandline Developer Tools ..."
	@xcode-select --install

homebrew:
	@echo "Installing homebrew ..."
	@ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	@echo "Installing libraries with homebrew ..."
	@brew bundle
	@echo "Installing Ricty ..."
	@cp -f /usr/local/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/
	@fc-cache -vf

apps-config:
	@echo "Setting Karabiner ..."
	@cp Karabiner/private.xml ~/Library/Application\ Support/Karabiner/private.xml
	@sh Karabiner/karabiner-import.sh

export:
	@echo "Exporting Karabiner's configuration ..."
	@cp ~/Library/Application\ Support/Karabiner/private.xml Karabiner/private.xml
	@sh /Applications/Karabiner.app/Contents/Library/bin/karabiner export > Karabiner/karabiner-import.sh

ruby-version = 2.1.0
ruby:
	@ln -sfv default-gems ~/.rbenv/default-gems || true
	@CONFIGURE_OPTS="--with-readline-dir=`brew --prefix` --with-openssl-dir=`brew --prefix openssl`" RUBY_CONFIGURE_OPTS="--with-openssl-dir=`brew --prefix openssl`" rbenv install $(ruby-version)
	@rbenv global $(ruby-version)

go:
	@go get github.com/motemen/ghq
	@git config --global ghq.root ~/src

zsh:
	@echo "Installing oh-my-zsh ..."
	@curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
	@mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc
	@chsh -s /usr/local/bin/zsh

shell:
	@echo "/usr/local/bin/zsh" >> /etc/shells
