is_within_range(){

        target=$1
        local start_value=$2
        local end_value=$3

        for x in $( seq $start_value $end_value ); do
                if [ "$x" = "$target" ];then
                        return 0
                fi
        done
        return 1

}

if is_within_range "$1" "$2" "$3"; then
	echo "yes"
else
	echo "no"
fi

