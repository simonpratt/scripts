#!/bin/sh -e

homedir=~
eval homedir=$homedir

if [ -d "$homedir/.oh-my-zsh" ]; then
    echo '[ok] .oh-my-zsh'
else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

cd scripts; git pull --rebase --prune $@ && git submodule update --init --recursive;

# create home bin dir
if [ -d "~/bin" ]; then
  echo '[ok] bin exists'
else
  echo "[bad] creating bin!"
  mkdir ~/bin
fi

# Install .bashrc
if grep 'scripts/.bashrc' ~/.bashrc
then
  echo '[ok] .bashrc'
else
  # Append rather than replace
  echo '. ~/scripts/.bashrc' >> ~/.bashrc
  echo 'Appended to .bashrc'
  source ~/.bashrc
fi

# Sym link diff-highlight dir
if [ -L ~/bin/diff-highlight ]; then
  echo "[ok] diff-highlight"
elif [ -e ~/bin/diff-highlight ]; then
  echo "[bad] diff-highlight exists!"
  rm -rf ~/bin/diff-highlight
  ln -s ~/scripts/diff-highlight ~/bin/diff-highlight
  echo "[ok] Created diff-highlight/ sym link"
else
  ln -s ~/scripts/diff-highlight ~/bin/diff-highlight
  echo "[ok] Created diff-highlight sym link"
fi



# Sym link .vim dir
if [ -L ~/.vim ]; then
  echo "[ok] .vim"
elif [ -e ~/.vim ]; then
  echo "[bad] .vim exists!"
  rm -rf ~/.vim
  ln -s ~/scripts/.vim ~/.vim
  echo "[ok] Created .vim/ sym link"
else
  ln -s ~/scripts/.vim ~/.vim
  echo "[ok] Created .vim/ sym link"
fi

# Sym link .vimrc
if [ -L ~/.vimrc ]; then
  echo "[ok] .vimrc"
elif [ -e ~/.vimrc ]; then
  echo "[bad] .vimrc exists!"
  
  rm ~/.vimrc
  ln -s ~/scripts/.vimrc ~/.vimrc
  echo "[ok] Created .vimrc sym link"
else
  ln -s ~/scripts/.vimrc ~/.vimrc
  echo "[ok] Created .vimrc sym link"
fi

# Sym link .gitconfig
if [ -L ~/.gitconfig ]; then
  echo "[ok] .gitconfig"
elif [ -e ~/.gitconfig ]; then
  echo "[bad] .gitconfig exists!"
  
  rm ~/.gitconfig
  ln -s ~/scripts/.gitconfig ~/.gitconfig
  echo "[ok] Created ~/.gitconfig sym link"
else
  ln -s ~/scripts/.gitconfig ~/.gitconfig
  echo "[ok] Created ~/.gitconfig sym link"
fi

# Sym link .gitconfig
if [ -L ~/.gitignore_global ]; then
  echo "[ok] .gitignore_global"
elif [ -e ~/.gitignore_global ]; then
  echo "[bad] .gitignore_global exists!"

  rm ~/.gitignore_global
  ln -s ~/scripts/.gitignore_global ~/.gitignore_global
  echo "[ok] Created ~/.gitignore_global sym link"
else
  ln -s ~/scripts/.gitignore_global ~/.gitignore_global
  echo "[ok] Created ~/.gitignore_global sym link"
fi

# Sym link .psqlrc
if [ -L ~/.psqlrc ]; then
  echo "[ok] .psqlrc"
elif [ -e ~/.psqlrc ]; then
  echo "[bad] .psqlrc exists!"

  rm ~/.psqlrc
  ln -s ~/scripts/.psqlrc ~/.psqlrc
  echo "[ok] Created ~/.psqlrc sym link"
else
  ln -s ~/scripts/.psqlrc ~/.psqlrc
  echo "[ok] Created ~/.psqlrc sym link"
fi

# Sym link .zshrc
if [ -L ~/.zshrc ]; then
  echo "[ok] .zshrc"
elif [ -e ~/.zshrc ]; then
  echo "[bad] .zshrc exists!"
else
  ln -s ~/scripts/.zshrc ~/.zshrc
  echo "[ok] Created ~/.zshrc sym link"
fi

