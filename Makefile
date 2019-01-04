DOTFILES_EXCLUDES := .DS_Store .git .gitmodules .gitignore
DOTFILES_TARGET   := $(wildcard .??*)
DOTFILES_FILES    := $(filter-out $(DOTFILES_EXCLUDES), $(DOTFILES_TARGET))
BINFILES_FILES    := $(wildcard bin/*)

default: update deploy

all: update deploy init brew

list:
	@$(foreach val, $(DOTFILES_FILES), ls -dF $(val);)

clean:
	@-$(foreach val, $(DOTFILES_FILES), rm -vrf $(HOME)/$(val);)
	-rm -rf $(PWD)

update:
	git pull origin master
	git submodule init
	git submodule update
	git submodule foreach git pull origin master

deploy:
	@$(foreach val, $(DOTFILES_FILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	@$(foreach val, $(BINFILES_FILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	@mkdir -p $(HOME)/.zsh
	@mkdir -p $(HOME)/.config
	@mkdir -p $(HOME)/.vimundo
	@mkdir -p $(HOME)/.ssh
	@mkdir -p $(HOME)/bin
	@ln -sfnv $(HOME)/.vim   $(HOME)/.config/nvim
	@ln -sfnv $(HOME)/.vimrc $(HOME)/.config/nvim/init.vim
	@ln -sfnv $(HOME)/.ssh_config $(HOME)/.ssh/config
	@ln -sfnv $(HOME)/dotfiles/.vim/plugin $(HOME)/.vim/plugin
	@ln -sfnv $(HOME)/dotfiles/.vim/indent $(HOME)/.vim/indent
	@ln -sfnv $(HOME)/dotfiles/.vim/syntax $(HOME)/.vim/syntax

init: gitconfig

gitconfig:
	git config --replace-all user.name dalance
	git config --replace-all user.email dalance@gmail.com

linuxbrew:
	if [ ! -e "$(HOME)/.linuxbrew" ]; then ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)";fi

brew: linuxbrew
	$(HOME)/.linuxbrew/bin/brew install gcc git tmux python3 ncftp
	$(HOME)/.linuxbrew/bin/brew install neovim/neovim/neovim
	$(HOME)/.linuxbrew/bin/brew tap universal-ctags/universal-ctags
	$(HOME)/.linuxbrew/bin/brew install --HEAD universal-ctags
