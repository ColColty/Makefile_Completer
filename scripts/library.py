import sys

def readWrite(path, writing=None):
    if writing == None:
        with open(path, 'r', encoding='utf-8') as file:
            content = file.read()
        return content
    with open(path, 'w', encoding='utf-8') as file:
        file.write(writing)


if __name__ == '__main':
    if len(sys.argv) < 2:
        print("This is the function to read and write on a file")
    file_content = readWrite(sys.argv[1], sys.argv[2])