import scripts.definers as define
import os

# TODO Make a better directory path finder with an implemented Makefile finder in the loop directory
def directory_finder(path):
    pathSplit = path.split('/')
    PathMakefile = []
    identifier = -1
    for file in pathSplit:
        if identifier != -1:
            break
        PathMakefile.append(file + "/")
        for i, ident in enumerate(define.IDENTIFIERS):
            if file == ident:
                identifier = i
    if identifier == -1:
        return 0, path
    elif identifier != 2 and identifier != 3:
        PathMakefile.remove(define.IDENTIFIERS[identifier] + "/")
    PathMakefile = ''.join(PathMakefile)
    return identifier, PathMakefile


if __name__ == '__main__':
    identifier, path = directory_finder(os.getcwd())
    print("The identifier is {}, and the path where it was is {}".format(
        identifier, path))
