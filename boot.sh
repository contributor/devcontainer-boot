HOME_BIN=~/bin
mkdir -p $HOME_BIN

# install justfile https://just.systems/man/en/chapter_5.html
if [ ! -e "$HOME_BIN/just" ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to ~/bin
    # in codespaces, .bashrc is taken from dotfiles repo and will overwrite the next line. Therefore, this line should be added in my .bashrc beforehand.
    echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc
fi

$HOME_BIN/just clone $1 $2