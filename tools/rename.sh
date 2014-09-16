find . -name "*bitcoin*"|
	while IFS= read -r;do 
                fpath="${REPLY%/*}/"
                fname="${REPLY##*/}"
		echo $fpath$fname
		mv "$REPLY" "${fpath}${fname/bitcoin/deuscoin}" 
	done
	
find . -name "*deus*"|
	while IFS= read -r;do 
                fpath="${REPLY%/*}/"
                fname="${REPLY##*/}"
		echo $fpath$fname
		mv "$REPLY" "${fpath}${fname/deus/deus}" 
	done

echo "Run this until there aren't any errors."
