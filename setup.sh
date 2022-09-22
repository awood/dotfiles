#! /bin/bash

link() {
    LOC=${2:-$HOME}
    if [ -e "$LOC/$1" ]; then
        echo "Cowardly refusing to overwrite $LOC/$1"
    # In case $2 is a file location
    elif [ -f "$LOC" ]; then
        echo "Cowardly refusing to overwrite $LOC"
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
    link "$f"
done;

declare -A other_files
other_files=( [bat.conf]="$HOME/.config/bat/config" )

for f in "${!other_files[@]}"; do
    link "$f" "${other_files[$f]}"
done;

if [ -d $HOME/.oh-my-zsh/ ]; then
    link awood.zsh-theme $HOME/.oh-my-zsh/custom/themes

    for d in $(find "$(pwd)/dotfiles/custom-zsh-plugins" -maxdepth 1 -mindepth 1 -type d -printf '%f\n'); do
        if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/$d" ]; then
            link "custom-zsh-plugins/$d" "$HOME/.oh-my-zsh/custom/plugins"
        else
            echo "Plugin directory for $d already exists"
        fi
    done

    for f in $(find "$(pwd)/dotfiles/custom-zsh" -maxdepth 1 -mindepth 1 -type f -printf '%f\n'); do
        if [ ! -d "$HOME/.oh-my-zsh/custom/$f" ]; then
            link "custom-zsh/$f" "$HOME/.oh-my-zsh/custom/$f"
        else
            echo "File $f already exists in .oh-my-zsh/custom"
        fi
    done
fi
