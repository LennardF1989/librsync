#! /bin/sh -pe

# Regression test suite for libhsync.

# Copyright (C) 2000 by Martin Pool
# $Id$

# Try some files specifically created to trip the library up.

files=`ls $srcdir/in-tricky/in-*`

diff=$tmpdir/diff.tmp
out=$tmpdir/out.tmp
sig=$tmpdir/sig.tmp
newsig=$tmpdir/newsig.tmp
old=/dev/null

fromsig=$tmpdir/fromsig.tmp
fromlt=$tmpdir/fromlt.tmp
ltfile=$tmpdir/lt.tmp

for from in $files
do
    run_test hsnad $debug /dev/null <$from >$ltfile
    run_test hsdecode $debug /dev/null $sig $out $ltfile
	
    run_test cmp $out $from
	
    for new in $files
    do
	countdown
	run_test hsnad $debug $sig <$new >$diff
	run_test hsdecode $debug $from $newsig $out $diff 
	    
	run_test cmp $out $new
    done
done