name=$1
i=1

if [ -z "$1"  ]; then 
echo "Please enter a name"

else 
  files=$(ls)
  for x in $files; do
    if [ $x != rename_all.sh  ]; then
      echo "$x ---  $name$i"
      mv $x $name$i
      i=$(( i + 1  )) 
    fi
  done
fi
