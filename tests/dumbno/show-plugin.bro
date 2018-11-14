# @TEST-EXEC: bro -NN NCSA::Dumbno |sed -e 's/version.*)/version)/g' >output
# @TEST-EXEC: btest-diff output
