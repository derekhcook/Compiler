for i in {101..178}; do
	echo "Processing file $i.dat..."
	diff "$i.lst" "/usr/local/4301/data/stage1/$i.lst"
done

echo "diff is done!"
