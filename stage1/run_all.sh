for i in {101..178}; do
	echo "processing file $i.dat..."
	./stage1 "$i.dat" "$i.lst" "$i.asm"
done

echo "All filed processed!"
