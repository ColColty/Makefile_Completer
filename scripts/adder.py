import scripts.definers as define
import scripts.library as lib
import re
import logging


def check_already_exists(all_lines, line_to_find):
    for line in all_lines:
        logging.debug(
            "++ FINDING Makefile Line: {}\t||\tto find -> {}".format(line, line_to_find))
        if re.search(line_to_find + "\\", line):
            logging.info("The line already exists")
            return line
    return None


def addFiletoMakefile(file):
    makeContent = lib.readWrite(path=file.makefile + "/Makefile", writing=None)
    line_list = makeContent.splitlines()

    logging.info("++++++ ADDING ++++++\n")
    logging.info("++ The file has de name of: {}".format(file.filename))
    fileLineMakefile = define.PATHS[file.identifier] + file.filename + "\t\\"
    logging.info("++ The expected line is: {}\n".format(fileLineMakefile))

    if check_already_exists(line_list, fileLineMakefile) != None:
        return

    for i, line in enumerate(line_list):
        logging.debug(
            "++ TO ADD Makefile line: {}\t||\tto find -> {}".format(line, fileLineMakefile))
        if re.match(define.MAKEFILE_VAR[file.identifier] + define.PATHS[file.identifier], line) or re.match(define.MAKEFILE_VAR[file.identifier] + "\t", line):
            logging.debug("++ The line starts here: {}".format(line))
            while line_list[i] != '':
                i += 1
            line_list.insert(i, fileLineMakefile)
            logging.debug("++ {} was added !\n\n".format(fileLineMakefile))
            break

    makeContent = '\n'.join(line_list)
    lib.readWrite(path=file.makefile + "/Makefile", writing=makeContent)
    logging.info("++ Line well added\n\n")


if __name__ == '__main__':
    print("This is are the functions to add a file to the Makefile")
