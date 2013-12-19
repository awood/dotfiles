#! /bin/sh

link() {
    ln -s dotfiles/$1 $HOME
}

files=(.vimrc .vim .screenrc .tmux.conf .zshrc .zfunc/ .gitconfig
    .gitignore .git_template/ .irbrc .psqlrc)

for f in ${files[@]}; do
    link $f
done;
