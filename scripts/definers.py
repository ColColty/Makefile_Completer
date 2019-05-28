import logging
import scripts.library as lib

JSON_FILES = ["data/config.json"]

IDENTIFIERS = []
PATHS = []
MAKEFILE_VAR = []


def load_definers():
    data = lib.json_loader(JSON_FILES[0])
    for folder in data:
        if folder["folder"] == "lib":
            IDENTIFIERS.append(folder["my"]["folder"])
            PATHS.append(folder["my"]["path"])
            MAKEFILE_VAR.append(folder["my"]["variable"])
        else:
            IDENTIFIERS.append(folder["folder"])
            PATHS.append(folder["path"])
            MAKEFILE_VAR.append(folder["variable"])

# TODO Add here call for functions to read the json files with configurations
