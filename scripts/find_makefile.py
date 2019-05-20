import scripts.definers as define
import os
import re
import logging

# TODO Make a better directory path finder with an implemented Makefile finder in the loop directory


def makefile_in_dir(curr_dir):
    for line in os.listdir(curr_dir):
        if re.match("Makefile", line):
            return True
    return False


def identify_it(element):
    for i, ident in enumerate(define.IDENTIFIERS):
        if ident == element:
            logging.debug("The identifier is: {}".format(define.IDENTIFIERS[i]))
            return i
    return None


def find_makefile(path):
    rev_path = path.split('/')[::-1]
    path_split = path.split('/')
    for current in rev_path:
        path_split.remove(current)
        if makefile_in_dir('/'.join(path_split)):
            logging.info("Path for the makefile {}".format('/'.join(path_split)))
            return '/'.join(path_split) + '/'
    return None


def directory_finder(path):
    makefile_path = find_makefile(path)
    for element in path.split('/')[::-1]:
        identifier = identify_it(element)
        if identifier != None:
            break
    return identifier, makefile_path


if __name__ == '__main__':
    identifier, path = directory_finder(os.getcwd())
    print("The identifier is {}, and the path where it was is {}".format(
        identifier, path))
