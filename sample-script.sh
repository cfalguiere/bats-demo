usage="usage: $0 -e exite-code -o value-to-output"
status=0
output=""
name=""
verbose=0
while getopts "hve:o:n:" opt; do
  case $opt in
    e)
      status=$OPTARG
      [[ $verbose -eq 1 ]] && echo "-e was triggered. Parameter: $status" >&2
      ;;
    o)
      output=$OPTARG
      [[ $verbose -eq 1 ]] && echo "-o was triggered. Parameter: $output" >&2
      ;;
    n)
      name=$OPTARG
      [[ $verbose -eq 1 ]] && echo "-n was triggered. Parameter: $name" >&2
      ;;
    v)
      verbose=1
      ;;
    h)
      echo $usage
      ;;
  esac
done
[[ -z $output ]] || echo -n "$output" 
[[ -z $name ]] || echo " $name"
[[ $status -eq 0 ]] || echo "FAILURE" && echo "SUCCESS" 
exit $status
