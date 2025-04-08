if [ ! -d tmp ]; then
	mkdir tmp
fi

i="barna"

echo $i
../cc65/bin/ca65 -D $i msbasic.s -o tmp/$i.o -v -v > tmp/$i.log &&
../cc65/bin/ld65 -C $i.cfg tmp/$i.o -o tmp/$i.bin -Ln tmp/$i.lbl

