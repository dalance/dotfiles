DOTFILES_EXCLUDES := .DS_Store .git .gitmodules .travis.yml
DOTFILES_TARGET   := $(wildcard .??*)
DOTFILES_FILES    := $(filter-out $(DOTFILES_EXCLUDES), $(DOTFILES_TARGET))

all: install

list:
	@$(foreach val, $(DOTFILES_FILES), ls -dF $(val);)

update:
	git pull origin master
	git submodule init
	git submodule update
	git submodule foreach git pull origin master

deploy:
	@$(foreach val, $(DOTFILES_FILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

init:
	@#$(foreach val, $(wildcard ./etc/init/*.sh), DOTPATH=$(PWD) bash $(val);)
	@#DOTPATH=$(PWD) bash $(PWD)/etc/init/init.sh

install: update deploy init
	@exec $$SHELL

clean:
	@-$(foreach val, $(DOTFILES_FILES), rm -vrf $(HOME)/$(val);)
	-rm -rf $(PWD)

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
