import scripts.definers as define
import os
import re
import logging


def makefile_in_dir(curr_dir):
    try:
        for line in os.listdir(curr_dir):
            if re.match("Makefile", line):
                return True
    except FileNotFoundError:
        logging.error("/!\\ ---- Error loading {} ---- /!\\".format(curr_dir))
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
            return '/'.join(path_split)
    logging.info("/!\\ ---- Makefile not founded for {} ---- /!\\".format(path))
    return None


def directory_finder(path):
    makefile_path = find_makefile(path)
    if not makefile_path:
        return None
    for element in path.split('/')[::-1]:
        identifier = identify_it(element)
        if identifier != None:
            break
    return identifier, makefile_path


if __name__ == '__main__':
    identifier, path = directory_finder(os.getcwd())
    print("The identifier is {}, and the path where it was is {}".format(
        identifier, path))
