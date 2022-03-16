#! /bin/sh

link() {
    LOC=${2:-$HOME}
    if [ -e "$LOC/$1" ]; then
        echo "Cowardly refusing to overwrite $LOC/$1"
    else
        ln -s "$(pwd)/dotfiles/$1" "$LOC"
        echo "Linking $1"
    fi
}

pushd $(pwd)/dotfiles
git submodule update --init --recursive
popd

files=(.vimrc .vim .screenrc .tmux.conf .zshrc .zfunc/ .gitconfig
    .gitignore .git_template/ .irbrc .psqlrc .tigrc .gdbinit .pryrc
    .less_colors .ackrc .ideavimrc .keychainrc .dircolors)

for f in ${files[@]}; do
    link $f
done;

if [ -d $HOME/.oh-my-zsh/ ]; then
    link awood.zsh-theme $HOME/.oh-my-zsh/custom/themes

    for d in $(find "$(pwd)/dotfiles/custom-zsh-plugins" -maxdepth 1 -mindepth 1 -type d -printf '%f\n'); do
        link "custom-zsh-plugins/$d" $HOME/.oh-my-zsh/custom/plugins
    done
fi
