
if [ -z $1 ] || [ -z $2 ]; then
  echo "Arguments: 1.aliasName 2.aliasValue"
  exit 
fi

_alias="alias $1=$2"
echo "$_alias" >> ~/.bashrc
