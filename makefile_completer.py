#!/usr/bin/python3

import time
import os
import re
import scripts.find_makefile as finder
import scripts.definers as define
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler




class FileEvent(FileSystemEventHandler):
    def on_created(self, event):
        if event.src_path[-1] == 'c' and event.src_path[-2] == '.':
            identifier, dir_path = finder.directory_finder(event.src_path)
            print("++ Path where the Makefile is: {}".format(dir_path))
            print("++ The file is in {} directory".format(define.PATHS[identifier]))
            if "Makefile" in os.listdir(dir_path):
                addFiletoMakefile(event.src_path, dir_path, identifier)
            else:
                print("++ Makefile not found in %s" % dir_path)
            print("\n++++++++ THE FILE WAS ADDED ++++++++\n\n\n")

    def on_deleted(self, event):
        if event.src_path[-1] == 'c' and event.src_path[-2] == '.':
            identifier, dir_path = finder.directory_finder(event.src_path)
            print("-- Path where the Makefile is: {}".format(dir_path))
            print("-- The file is in {} directory".format(define.PATHS[identifier]))
            if "Makefile" in os.listdir(dir_path):
                removeFilefromMakefile(event.src_path, dir_path, identifier)
            else:
                print("-- Makefile not found in %s" % dir_path)
            print("\n-------- THE FILE WAS REMOVED --------\n\n\n")

    def on_moved(self, event):
        if event.src_path[-1] == 'c' and event.src_path[-2] == '.':
            print("\n=== {} was moved to {} ===\n".format(
                event.src_path, event.dest_path))
            identifier, dir_path = finder.directory_finder(event.src_path)
            print("== Path where the Makefile is: {}".format(dir_path))
            print("== The file is in {} directory".format(define.PATHS[identifier]))
            if "Makefile" in os.listdir(dir_path):
                removeFilefromMakefile(event.src_path, dir_path, identifier)
            else:
                print("== Makefile not found in %s" % dir_path)
            identifier, dir_path = finder.directory_finder(event.dest_path)
            print("==Path where the Makefile is: {}".format(dir_path))
            print("==The file is in {} directory".format(define.PATHS[identifier]))
            if "Makefile" in os.listdir(dir_path):
                addFiletoMakefile(event.dest_path, dir_path, identifier)
            else:
                print("== Makefile not found int %s" % dir_path)
            print("\n======== THE FILE WAS MOVED =========\n\n\n")


def readWrite(path, writing=None):
    if writing == None:
        with open(path, 'r', encoding='utf-8') as Makefile:
            makeContent = Makefile.read()
        return makeContent
    with open(path, 'w', encoding='utf-8') as Makefile:
        Makefile.write(writing)


def addFiletoMakefile(realPath, dir_path, identifier):
    makeContent = readWrite(path=dir_path + "Makefile", writing=None)
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
    readWrite(path=dir_path + "Makefile", writing=makeContent)
    print("++ Line well added\n\n")


def removeFilefromMakefile(realPath, dir_path, identifier):
    makeContent = readWrite(path=dir_path + "Makefile", writing=None)
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
    readWrite(path=dir_path + "Makefile", writing=makeContent)
    print("-- Line well removed\n\n")


if __name__ == '__main__':
    observer = Observer()
    event_handler = FileEvent()
    # observer.schedule(event_handler, path="/home/tforne/Documents/Epitech/Porfolio/Makefile_Completer/testing", recursive=True)
    observer.schedule(event_handler, path="/home", recursive=True)
    observer.start()

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()

    observer.join()
