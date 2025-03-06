for i in {150..178}; do
	echo "processing file $i"
	cat "$i.lst"
	cat "/usr/local/4301/data/stage1/$i.dat"
	echo "      "
	echo "      "
	echo "      "
	echo "      "
done

echo "Finished!"
