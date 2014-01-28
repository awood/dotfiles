#! /bin/sh

link() {
    LOC=${2:-$HOME}
    if [ -e $LOC/$1 ]; then
        echo "Cowardly refusing to overwrite $LOC/$1"
    else
        ln -s $(pwd)/dotfiles/$1 $LOC
        echo "Linking $1"
    fi
}

pushd $(pwd)/dotfiles
git submodule update --init --recursive
popd

files=(.vimrc .vim .screenrc .tmux.conf .zshrc .zfunc/ .gitconfig
    .gitignore .git_template/ .irbrc .psqlrc)

for f in ${files[@]}; do
    link $f
done;

if [ -d $HOME/.oh-my-zsh/ ]; then
    link awood.zsh-theme $HOME/.oh-my-zsh/custom
fi
