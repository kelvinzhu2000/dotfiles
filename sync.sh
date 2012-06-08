SOURCE="${BASH_SOURCE[0]}"
DIR="$( dirname "$SOURCE" )"
while [ -h "$SOURCE" ]
do 
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
  DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd )"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

for file in $DIR/\.*
do
    if [[ $file =~ .*\/\.$ || $file =~ .*\/\.\.$ ]]
    then
        echo "ignoring "$file
    elif [[ $file =~ .*\/\.git$ ]]
    then
        echo "ignoring "$file
    elif [[ $file =~ .*\.swp$ ]]
    then
        echo "ignoring "$file
    else
        echo "linking "$file
        ln -s $file ~
    fi
done
