def readWrite(path, writing=None):
    if writing == None:
        with open(path, 'r', encoding='utf-8') as Makefile:
            makeContent = Makefile.read()
        return makeContent
    with open(path, 'w', encoding='utf-8') as Makefile:
        Makefile.write(writing)