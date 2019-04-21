import re
import sys


def finder(file_data):
    try:
        with open(file_data[0] + 'Makefile', 'r', encoding='utf-8') as Makefile:
            data = Makefile.read()
    except EnvironmentError:
        raise Exception("There is no Makefile in the path: {}".format(file_data[0]))
    data_splitted = data.split('\n')
    for i, line in enumerate(data_splitted):
        if re.match(file_data[1], line):
            while data_splitted[i] != '':
                if file_data[2] in data_splitted[i]:
                    return
                i += 1
            raise Exception("The file isn't added on the Makefile")


def error_handle():
    if len(sys.argv) != 4:
        raise Exception("Bad number of arguments")

    path_makefile = sys.argv[1]
    variable_makefile = sys.argv[2]
    line_makefile = sys.argv[3]
    if variable_makefile == 'SRC\t=' and path_makefile == './testing/':
        line_makefile = '$(SRC_DIR)' + line_makefile
    elif variable_makefile == 'TESTS\t=' and path_makefile == './testing/':
        line_makefile = '$(TEST_SRC)' + line_makefile

    return path_makefile, variable_makefile, line_makefile


def main():
    file_data = error_handle()
    finder(file_data)


if __name__ == '__main__':
    try:
        main()
    except Exception as e:
        print(e)
        sys.exit(84)