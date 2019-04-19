#!/bin/bash

test_arguments_good()
{
    echo "timeout 2 ./$EXEC $@"
    timeout 2 ./$EXEC $@
    RET=`echo $?`

    if [ $RET -ne 0 ]; then
        echo -e "\033[1;31mTest $COUNTER failed with code: $RET\033[0m"
        exit 84
    else
        COUNTER=$((COUNTER + 1))
        echo -e "\033[1;32mTest $COUNTER passed\033[0m"
    fi
}

test_arguments_bad()
{
    echo "timeout 2 ./$EXEC $@"
    timeout 2 ./$EXEC $@
    RET=`echo $?`

    if [ $RET -ne 84 ]; then
        echo -e "\033[1;31mTest $COUNTER failed with code: $RET\033[0m"
        exit 84
    else
        COUNTER=$((COUNTER + 1))
        echo -e "\033[1;32mTest $COUNTER passed\033[0m"
    fi
}


#============== Declaring values ==============

EXEC=$1
COUNTER=0

#============== Doing exception for unit tests if needed for timeouts ==============

if [ $1 = "unit_tests" ]; then
    test_arguments "--always-succeed"
    exit
else
    make re
fi

#============== Add more tests here ==============

test_arguments_bad 1 2
test_arguments_bad 2
test_arguments_bad -h
echo -e "\033[1mTESTING === test_arguments_good\033[0m"
test_arguments_good