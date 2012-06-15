#!/bin/sh

SOURCE="${BASH_SOURCE[0]}"
DIR="$( dirname "$SOURCE" )"
while [ -h "$SOURCE" ]
do 
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
  DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd )"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

rm -rf .oh-my-zsh/themes/bunsen.zsh-theme
cp bunsen.zsh-theme .oh-my-zsh/themes/

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
