import scripts.library as lib
import scripts.definers as define
import scripts.find_makefile as finder
import re
import logging
import os


def removeDirectory(folder):
    logging.debug("-- The folder {} items will be deleted".format(folder.folder_name))
    identifier, make_path = finder.directory_finder(folder.pwd_folder)
    make_content = lib.readWrite(path=make_path + "/Makefile")
    make_list = make_content.splitlines()

    logging.info("------ REMOVING ------\n")

    for line in make_list:
        logging.debug("-- FINDING Makefile Line: {}\t || \tto find -> {}".format(line, folder.folder_name + '/'))
        if re.search(folder.folder_name + '/', line) and  re.search(define.PATHS[identifier], line):
            logging.info("-- Removing {} line from makefile".format(line))
            make_list.remove(line)
    make_content = '\n'.join(make_list)
    lib.readWrite(path=make_path + "/Makefile", writing=make_content)
    logging.info("-- All files from the directory has been removed from the Makefile")


def removeFilefromMakefile(file):
    makeContent = lib.readWrite(path=file.makefile + "/Makefile")
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
    lib.readWrite(path=file.makefile + "/Makefile", writing=makeContent)
    logging.info("-- Line well removed\n\n")


if __name__ == '__main__':
    print("This are the functions to remove a file from a Makefile")
