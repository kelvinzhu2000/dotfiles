#!/bin/sh
echo "$( dirname $0 )"
DIR="$( dirname $0 )"

rm -rf $DIR/.oh-my-zsh/themes/bunsen.zsh-theme
cp $DIR/bunsen.zsh-theme $DIR/.oh-my-zsh/themes/

for file in $DIR/\.*
do
    [[ $file =~ (\.([-_a-zA-Z0-9])+)*$ ]]
    baseFile=$BASH_REMATCH

    if [[ $file =~ .*\/\.$ || $file =~ .*\/\.\.$ ]]
    then
        echo "ignoring $file"
    elif [[ $file =~ .*\/\.git$ ]]
    then
        echo "ignoring $file"
    elif [[ $file =~ .*\.swp$ ]]
    then
        echo "ignoring $file"
    else
        if [[ -a ~/$baseFile ]]
        then
            echo "removing $baseFile"
            rm -rf ~/$baseFile
        fi
        echo "linking $file"
        ln -s $file ~
    fi
done
