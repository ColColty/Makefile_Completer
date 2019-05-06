import scripts.definers as define
import scripts.library as lib
import re
import os

def addFiletoMakefile(realPath, dir_path, identifier):
    makeContent = lib.readWrite(path=dir_path + "Makefile", writing=None)
    line_list = makeContent.splitlines()

    print("++++++ ADDING ++++++\n")
    fileName = realPath.replace(dir_path + ((define.IDENTIFIERS[identifier] + '/') if identifier != 2 else ''), '')
    print("++ The file has de name of: {}".format(fileName))
    fileLineMakefile = define.PATHS[identifier] + fileName + "\t\\"
    print("++ The expected line is: {}\n".format(fileLineMakefile))

    for line in line_list:
        print(
            "++ FINDING Makefile Line: {}\t||\tto find -> {}".format(line, fileLineMakefile))
        if re.search(fileLineMakefile + "\\", line):
            return

    for i, line in enumerate(line_list):
        print("++ TO ADD Makefile line: {}\t||\tto find -> {}".format(line, fileLineMakefile))
        if re.match(define.MAKEFILE_VAR[identifier] + define.PATHS[identifier], line) or re.match(define.MAKEFILE_VAR[identifier] + "\t", line):
            print("++ The line starts here: {}".format(line))
            while line_list[i] != '':
                i += 1
            line_list.insert(i, fileLineMakefile)
            print("++ {} was added !\n\n".format(fileLineMakefile))
            break

    makeContent = '\n'.join(line_list)
    lib.readWrite(path=dir_path + "Makefile", writing=makeContent)
    print("++ Line well added\n\n")

if __name__ == '__main__':
    print("This is are the functions to add a file to the Makefile")