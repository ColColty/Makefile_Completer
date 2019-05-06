#!/usr/bin/python3

import time
import os
import scripts.find_makefile as finder
import scripts.definers as define
import scripts.adder as add
import scripts.remover as rm
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

class FileEvent(FileSystemEventHandler):
    def on_created(self, event):
        if event.src_path[-1] == 'c' and event.src_path[-2] == '.':
            identifier, dir_path = finder.directory_finder(event.src_path)
            print("++ Path where the Makefile is: {}".format(dir_path))
            print("++ The file is in {} directory".format(define.PATHS[identifier]))
            if "Makefile" in os.listdir(dir_path):
                add.addFiletoMakefile(event.src_path, dir_path, identifier)
            else:
                print("++ Makefile not found in %s" % dir_path)
            print("\n++++++++ THE FILE WAS ADDED ++++++++\n\n\n")

    def on_deleted(self, event):
        if event.src_path[-1] == 'c' and event.src_path[-2] == '.':
            identifier, dir_path = finder.directory_finder(event.src_path)
            print("-- Path where the Makefile is: {}".format(dir_path))
            print("-- The file is in {} directory".format(define.PATHS[identifier]))
            if "Makefile" in os.listdir(dir_path):
                rm.removeFilefromMakefile(event.src_path, dir_path, identifier)
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
                rm.removeFilefromMakefile(event.src_path, dir_path, identifier)
                add.addFiletoMakefile(event.dest_path, dir_path, identifier)
            else:
                print("== Makefile not found in %s" % dir_path)
            print("\n======== THE FILE WAS MOVED =========\n\n\n")


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
