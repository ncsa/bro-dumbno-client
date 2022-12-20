# @TEST-EXEC: zeek -NN NCSA::Dumbno |sed -e 's/version.*)/version)/g' >output
# @TEST-EXEC: btest-diff output
