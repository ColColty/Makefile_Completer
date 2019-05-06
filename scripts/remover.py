import scripts.library as lib
import scripts.definers as define
import re

def removeFilefromMakefile(realPath, dir_path, identifier):
    makeContent = lib.readWrite(path=dir_path + "Makefile", writing=None)
    line_list = makeContent.splitlines()

    print("------ REMOVING ------\n")
    fileName = realPath.replace(dir_path + ((define.IDENTIFIERS[identifier] + "/") if identifier != 2 else ''), '')
    print("-- The file name is: {}\n".format(fileName))

    for line in line_list:
        print("-- FINDING Makefile Line: {}\t||\tto find -> {}".format(line,
                                                                       define.PATHS[identifier] + fileName,))
        if define.PATHS[identifier] + fileName in line:
            if re.match(define.MAKEFILE_VAR[identifier] + "\t", line):
                print("-- Adding the header because we remove it")
                line_list.insert(line_list.index(
                    line), define.MAKEFILE_VAR[identifier] + "\t\\")
            line_list.remove(line)
            print("-- {} removed !\n".format(line))
            break

    makeContent = '\n'.join(line_list)
    lib.readWrite(path=dir_path + "Makefile", writing=makeContent)
    print("-- Line well removed\n\n")

if __name__ == '__main__':
    print("This are the functions to remove a file from a Makefile")