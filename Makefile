all: symlink developer-tools homebrew fonts apps-config ruby go zsh
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

fonts:
	@echo "Installing Ricty ..."
	@cp -f /usr/local/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/
	@fc-cache -vf

apps-config:
	@echo "Installing lua modules for mjolnir"
	@for m in hotkey application window fnutils; do luarocks install mjolnir.$m; done

ruby-version = 2.7.1
ruby:
	@ln -sfv $PWD/default-gems ~/.rbenv/default-gems || true
	@CONFIGURE_OPTS="--with-readline-dir=`brew --prefix` --with-openssl-dir=`brew --prefix openssl`" RUBY_CONFIGURE_OPTS="--with-openssl-dir=`brew --prefix openssl`" rbenv install $(ruby-version)
	@rbenv global $(ruby-version)

go:
	@git config --global ghq.root ~/src

zsh:
	@echo "Installing oh-my-zsh ..."
	@curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
	@mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc

