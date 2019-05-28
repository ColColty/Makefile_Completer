import scripts.library as lib

JSON_FILES = ["data/config.json"]

IDENTIFIERS = []
PATHS = []
MAKEFILE_VAR = []


def load_definers():
    data = lib.json_loader(JSON_FILES[0])
    for item in data:
        if data[item]["folder"] == "lib":
            IDENTIFIERS.append(data[item]["my"]["folder"])
            PATHS.append(data[item]["my"]["path"])
            MAKEFILE_VAR.append(data[item]["my"]["variable"])
        else:
            IDENTIFIERS.append(data[item]["folder"])
            PATHS.append(data[item]["path"])
            MAKEFILE_VAR.append(data[item]["variable"])

# TODO Add here call for functions to read the json files with configurations
