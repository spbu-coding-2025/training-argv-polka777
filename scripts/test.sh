#!/bin/sh -e

BASEDIR=$(realpath "$(dirname "$0")")
ROOTDIR=$(realpath "$BASEDIR/..")
SEQ="$ROOTDIR/build/src/seq"
TESTDIR="$ROOTDIR/test"

START=1
END=6
RC=0
for i in $(seq $START $END); do
	echo "TEST $i RUNNING"
	TEST_FAILED=0
	if [ -f "$TESTDIR/${i}.out" ]; then
		if ! xargs -a "$TESTDIR/${i}.in" "$SEQ" | diff -B -Z - "$TESTDIR/${i}.out"; then
			TEST_FAILED=1
		fi
	else
		SEQ_RC=0
		xargs -a "$TESTDIR/${i}.in" "$SEQ" 1>/dev/null 2>&1 || SEQ_RC=$?
		if [ "$SEQ_RC" -ne 123 ]; then
			TEST_FAILED=1
		fi
		if ! xargs -a "$TESTDIR/${i}.in" "$SEQ" 2>&1 1>/dev/null | diff -B -Z - "$TESTDIR/${i}.err"; then
			TEST_FAILED=1
		fi
	fi
	if [ "$TEST_FAILED" -eq 0 ]; then
		echo "TEST $i OK"
	else
		echo "TEST $i FAILED"
		RC=1
	fi
done

exit $RC
