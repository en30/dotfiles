all: symlink developer-tools homebrew ruby apps-config oh-my-zsh
minimum: symlink oh-my-zsh

symlink:
	@echo "Creating Symlink ..."
	@sh symlink.sh

developer-tools:
	@echo "Installing Commandline Developer Tools ..."
	@xcode-select --install

homebrew:
	@echo "Installing homebrew ..."
	@ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
	@echo "Installing libraries with homebrew ..."
	@brew bundle
	@ln -sfv /usr/local/opt/td-agent/*.plist ~/Library/LaunchAgents
	@echo "Installing Ricty ..."
	@cp -f /usr/local/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/
	@fc-cache -vf

ruby-version = 2.1.0
ruby:
	@ln -sfv default-gems ~/.rbenv/default-gems || true
	@CONFIGURE_OPTS="--with-readline-dir=`brew --prefix` --with-openssl-dir=`brew --prefix openssl`" RUBY_CONFIGURE_OPTS="--with-openssl-dir=`brew --prefix openssl`" rbenv install $(ruby-version)
	@rbenv global $(ruby-version)

apps-config:
	@cp -ib org.pqrs.KeyRemap4MacBook.plist ~/Library/Preferences/org.pqrs.KeyRemap4MacBook.plist || true
	@cp -ib com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist || true

oh-my-zsh:
	@echo "Installing oh-my-zsh ..."
	@curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
