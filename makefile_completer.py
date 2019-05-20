#!/usr/bin/python3

import time
import os
import scripts.find_makefile as finder
import scripts.definers as define
import scripts.adder as add
import scripts.remover as rm
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
import logging


class dataFile:
    def __init__(self, pwd, makefile_directory, ident, new_pwd=None):
        self.pwd = pwd
        self.moved_pwd = new_pwd
        self.makefile = makefile_directory
        self.identifier = ident
        self.filename = self.find_filename()
        self.file_path = self.source_path()

    def find_filename(self):
        reverse_path = self.pwd.split('/')[::-1]
        filename = []
        for element in reverse_path:
            if element != define.IDENTIFIERS[self.identifier]:
                filename.append(element)
            else:
                break
        filename = filename[::-1]
        return '/'.join(filename)

    def source_path(self):
        reverse_path = self.pwd.split('/')[::-1]
        reverse_path = reverse_path.pop(0)
        file_path = []
        for element in reverse_path:
            if element != define.IDENTIFIERS[self.identifier] and element != self.filename:
                file_path.append(element)
        file_path = file_path[::-1]
        return '/'.join(file_path)


class FileEvent(FileSystemEventHandler):
    def on_created(self, event):
        file, ext = os.path.splitext(event.src_path)
        logging.info("++ Extension of \"{}\" and the path is {}".format(ext, file))
        if ext == ".c":
            identifier, dir_path = finder.directory_finder(event.src_path)
            logging.info("++ Path where the Makefile is: {}".format(dir_path))
            logging.info(
                "++ The file is in {} directory".format(define.PATHS[identifier]))
            newFile = dataFile(event.src_path, dir_path, identifier)
            if "Makefile" in os.listdir(dir_path):
                add.addFiletoMakefile(newFile)
            else:
                logging.error("++ Makefile not found in %s" % dir_path)
            logging.info("\n++++++++ THE FILE WAS ADDED ++++++++\n\n\n")

    def on_deleted(self, event):
        file, ext = os.path.splitext(event.src_path)
        logging.info("-- Extension of \"{}\" and the path is {}".format(ext, file))
        if ext == ".c":
            identifier, dir_path = finder.directory_finder(event.src_path)
            logging.info("-- Path where the Makefile is: {}".format(dir_path))
            logging.info(
                "-- The file is in {} directory".format(define.PATHS[identifier]))
            delFile = dataFile(event.src_path, dir_path, identifier)
            if "Makefile" in os.listdir(dir_path):
                rm.removeFilefromMakefile(delFile)
            else:
                logging.error("-- Makefile not found in %s" % dir_path)
            logging.info("\n-------- THE FILE WAS REMOVED --------\n\n\n")
        if event.is_directory:
            print("is_directory")

    def on_moved(self, event):
        file, ext = os.path.splitext(event.src_path)
        logging.info("== Extension of \"{}\" and the path is {}".format(ext, file))
        if ext == ".c":
            logging.info("\n=== {} was moved to {} ===\n".format(
                event.src_path, event.dest_path))
            identifier, dir_path = finder.directory_finder(event.src_path)
            logging.info("== Path where the Makefile is: {}".format(dir_path))
            logging.info("== The file is in {} directory".format(
                define.PATHS[identifier]))
            baseFile = dataFile(event.src_path, dir_path,
                                 identifier)
            identifier, dir_path = finder.directory_finder(event.dest_path)
            movedFile = dataFile(event.dest_path, dir_path, identifier)
            if "Makefile" in os.listdir(dir_path):
                rm.removeFilefromMakefile(baseFile)
                add.addFiletoMakefile(movedFile)
            else:
                logging.error("== Makefile not found in %s" % dir_path)
            logging.info("\n======== THE FILE WAS MOVED =========\n\n\n")


if __name__ == '__main__':
    observer = Observer()
    event_handler = FileEvent()
    # observer.schedule(event_handler, path="/home/tforne/Documents/Epitech/Porfolio/Makefile_Completer/testing", recursive=True)
    observer.schedule(event_handler, path="/home", recursive=True)
    observer.start()
    logging.basicConfig(level=logging.DEBUG)

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()

    observer.join()
