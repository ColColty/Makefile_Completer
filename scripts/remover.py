import scripts.library as lib
import scripts.definers as define
import re
import logging


def removeFilefromMakefile(file):
    makeContent = lib.readWrite(path=file.makefile + "Makefile")
    line_list = makeContent.splitlines()

    logging.info("------ REMOVING ------\n")
    logging.info("-- The file name is: {}\n".format(file.filename))

    for line in line_list:
        logging.debug("-- FINDING Makefile Line: {}\t||\tto find -> {}".format(line,
                                                                               define.PATHS[file.identifier] + file.filename,))
        if define.PATHS[file.identifier] + file.filename in line:
            if re.match(define.MAKEFILE_VAR[file.identifier] + "\t", line):
                logging.info("-- Adding the header because we remove it")
                line_list.insert(line_list.index(
                    line), define.MAKEFILE_VAR[file.identifier] + "\t\\")
            line_list.remove(line)
            logging.debug("-- {} removed !\n".format(line))
            break

    makeContent = '\n'.join(line_list)
    lib.readWrite(path=file.makefile + "Makefile", writing=makeContent)
    logging.info("-- Line well removed\n\n")


if __name__ == '__main__':
    print("This are the functions to remove a file from a Makefile")
