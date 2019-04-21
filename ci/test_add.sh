#!/bin/bash

echo "\033[1m Testing whem we the file has a bad extension\033[0m"

touch testing/src/bad_extension_file.pdf

python3 ./ci/tests/find_file.py "./testing/" "SRC\t=" "/bad_extension_file.pdf"

if [ $? -ne 84 ]; then
    echo "When the file has another extension than \".c\" it won't be add to Makefile"
    exit 84
fi

rm testing/src/bad_extension_file.pdf

echo "\033[1;32mTest 1 passed\033[0m"

echo "\033[1m Testing whem we add a file in src\033[0m"

touch testing/src/good_file.c

python3 ./ci/tests/find_file.py "./testing/" "SRC\t=" "/good_file.c"

if [ $? -ne 0 ]; then
    echo "When a file with \".c\" extension was created it would be added to Makefile"
    exit 84
fi

rm testing/src/good_file.c

echo "\033[1;32mTest 2 passed\033[0m"

echo "\033[1m Testing whem we add a file on a folder in src\033[0m"

mkdir testing/src/folder
touch testing/src/folder/good_file.c

python3 ./ci/tests/find_file.py "./testing/" "SRC\t=" "/folder/good_file.c"

if [ $? -ne 0 ]; then
    echo "When a file with \".c\" extension was created it would be added to Makefile"
    exit 84
fi

rm testing/src/folder/good_file.c

echo "\033[1;32mTest 3 passed\033[0m"

echo "\033[1m Testing whem we add a file on tests\033[0m"

touch testing/tests/good_tests_file.c

python3 ./ci/tests/find_file.py "./testing/" "TESTS\t=" "/good_tests_file.c"

if [ $? -ne 0 ]; then
    echo "When a file with \".c\" extension was created it would be added to Makefile"
    exit 84
fi

rm testing/tests/good_tests_file.c

echo "\033[1;32mTest 4 passed\033[0m"

echo "\033[1m Testing whem we add a file in a folder in tests\033[0m"

mkdir testing/tests/folder
touch testing/tests/folder/good_tests_file.c

python3 ./ci/tests/find_file.py "./testing/" "TESTS\t=" "/folder/good_tests_file.c"

if [ $? -ne 0 ]; then
    echo "When a file with \".c\" extension was created it would be added to Makefile"
    exit 84
fi

rm testing/tests/folder/good_tests_file.c

echo "\033[1;32mTest 5 passed\033[0m"

echo "\033[1m Testing whem we add a file in lib/my\033[0m"

touch testing/lib/my/good_lib_file.c

python3 ./ci/tests/find_file.py "./testing/lib/my/" "SRC\t=" "\tgood_lib_file.c"

if [ $? -ne 0 ]; then
    echo "When a file with \".c\" extension was created it would be added to Makefile"
    exit 84
fi

rm testing/lib/my/good_lib_file.c

echo "\033[1;32mTest 6 passed\033[0m"

echo "\033[1m Testing whem we add a file in a folder in lib/my\033[0m"


mkdir testing/lib/my/folder
touch testing/lib/my/folder/good_lib_file.c

python3 ./ci/tests/find_file.py "./testing/lib/my" "SRC\t=" "\tfolder/good_lib_file.c"

if [ $? -ne 0 ]; then
    echo "When a file with \".c\" extension was created it would be added to Makefile"
    exit 84
fi

rm testing/lib/my/folder/good_lib_file.c

echo "\033[1;32mTest 7 passed\033[0m"

exit 0