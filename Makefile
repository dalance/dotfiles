DOTFILES_EXCLUDES := .DS_Store .git .gitmodules .travis.yml .gitignore
DOTFILES_TARGET   := $(wildcard .??*)
DOTFILES_FILES    := $(filter-out $(DOTFILES_EXCLUDES), $(DOTFILES_TARGET))

all: install

install: update deploy init

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
	@ln -sfnv ~/.vim   ~/.config/nvim
	@ln -sfnv ~/.vimrc ~/.config/nvim/init.vim

init: gitconfig vimbuild tmuxbuild neobundle

gitconfig:
	git config --replace-all user.name dalance
	git config --replace-all user.email dalance@gmail.com

prebuild:
	if [ ! -d "build" ]; then mkdir build; fi

vimbuild: prebuild
	if [ -d "build/vim" ]; then cd build/vim; hg pull -u; cd ../..; else hg clone https://vim.googlecode.com/hg/ build/vim; fi
	cd build/vim/src; ./configure --with-features=huge --enable-pythoninterp --enable-rubyinterp --enable-luainterp --enable-fail-if-missing
	make -C build/vim/src
	sudo make -C build/vim/src install

tmuxbuild: prebuild
	if [ -d "build/tmux" ]; then cd build/tmux; git pull origin master; cd ../..; else git clone https://github.com/tmux/tmux.git build/tmux; fi
	cd build/tmux; sh autogen.sh; ./configure;
	make -C build/tmux
	sudo make -C build/tmux install

neovimbuild: prebuild
	if [ -d "build/neovim" ]; then cd build/neovim; git pull origin master; cd ../..; else git clone git://github.com/neovim/neovim build/neovim; fi
	make -C build/neovim cmake
	make -C build/neovim
	sudo make -C build/neovim install

neobundle:
	if [ ! -d "~/.vim/bundle" ]; then mkdir -p ~/.vim/bundle; fi
	if [ ! -d "~/.vim/bundle/neobundle.vim" ]; then git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim; fi
