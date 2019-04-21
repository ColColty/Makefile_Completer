#!/bin/bash

touch testing/src/bad_extension_file.pdf

python3 ./ci/tests/find_file.py "./testing/" "SRC\t=" "/bad_extension_file.pdf"

if [ $? -ne 84 ]; then
    echo "When the file has another extension than \".c\" it won't be add to Makefile"
    exit 84
fi

rm testing/src/bad_extension_file.pdf

touch testing/src/good_file.c

python3 ./ci/tests/find_file.py "./testing/" "SRC\t=" "/good_file.c"

if [ $? -ne 0 ]; then
    echo "When a file with \".c\" extension was created it would be added to Makefile"
    exit 84
fi

rm testing/src/good_file.c

mkdir testing/src/folder
touch testing/src/folder/good_file.c

python3 ./ci/tests/find_file.py "./testing/" "SRC\t=" "/folder/good_file.c"

if [ $? -ne 0 ]; then
    echo "When a file with \".c\" extension was created it would be added to Makefile"
    exit 84
fi

rm testing/src/folder/good_file.c

touch testing/tests/good_tests_file.c

python3 ./ci/tests/find_file.py "./testing/" "TESTS\t=" "/good_tests_file.c"

if [ $? -ne 0 ]; then
    echo "When a file with \".c\" extension was created it would be added to Makefile"
    exit 84
fi

rm testing/tests/good_tests_file.c

mkdir testing/tests/folder
touch testing/tests/folder/good_tests_file.c

python3 ./ci/tests/find_file.py "./testing/" "TESTS\t=" "/folder/good_tests_file.c"

if [ $? -ne 0 ]; then
    echo "When a file with \".c\" extension was created it would be added to Makefile"
    exit 84
fi

rm testing/tests/folder/good_tests_file.c

touch testing/lib/my/good_lib_file.c

python3 ./ci/tests/find_file.py "./testing/lib/my/" "SRC\t=" "\tgood_lib_file.c"

if [ $? -ne 0 ]; then
    echo "When a file with \".c\" extension was created it would be added to Makefile"
    exit 84
fi

rm testing/lib/my/good_lib_file.c

mkdir testing/lib/my/folder
touch testing/lib/my/folder/good_lib_file.c

python3 ./ci/tests/find_file.py "./testing/lib/my" "SRC\t=" "\tfolder/good_lib_file.c"

if [ $? -ne 0 ]; then
    echo "When a file with \".c\" extension was created it would be added to Makefile"
    exit 84
fi

rm testing/lib/my/folder/good_lib_file.c

exit 0