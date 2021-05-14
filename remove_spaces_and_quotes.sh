#!/bin/bash
# while IFS= read -r f;

# while IFS= read -r -d '' f;
# do
# 	# https://stackoverflow.com/questions/28256178/how-can-i-match-spaces-with-a-regexp-in-bash/28256343
# 	nospace="${f//[[:space:]*]/_}"
# 	echo $nospace
# 	mv -- "$f" "$nospace"
# done < <(find . -type d -print0)

while IFS= read -r -d '' f;
do
	# https://stackoverflow.com/questions/28256178/how-can-i-match-spaces-with-a-regexp-in-bash/28256343
	noquotes="${f//\"/}"
	nospace="${noquotes//[[:space:]*]/_}"
	nocolon="${nospace//:/}"
	mv -- "$f" "$noquotes";
	mv -- "$noquotes" "$nospace";
	mv -- "$nospace" "$nocolon";
done < <(find . -type f \( -name '*.mp3' -o -name "*.flac" \) -print0)