<p>
  <h1 align="center">Makefile Completer</h1>
</p>

**TAGS:** [![Build Status](https://travis-ci.com/ColColty/Makefile_Completer.svg?branch=master)](https://travis-ci.com/ColColty/Makefile_Completer)

## Desription

This program was done to be runned on a container in the background and do all the tasks mentioned below.

### Work on files

- If we create a new file in the project structure, it will be noticed by the program.
If the extension of the file is `.c` it would be follow on the add function to add a new line on the Makefile. If the file hasn't `.c` extension the program will continue to listen the folders.

- If we remove a file in the project structure, and the file has the `.c` extension, the line containing the filename on the Makefile will be removed.

- If we move a file in the project structure, it will find the Makefile at the root of the project structure where it was and erase the line. After doing this it will add a new line to the Makefile at the root of the project structure where it is now.

### Work on folders

- If we delete a folder, all the things related to this folder in the Makefile will be removed from it. All the files and variables are removed

## Base Makefile

This project consist on a program that will be running in background and will complete your project Makefile.

This program is based on my Makefile model:
- For the source files:
  - The source files are added on `SRC\t=` variable
  - The variable containing the directory of the source files is: `SRC_DIR` and in the line it would be: `\t$(SRC_DIR)/`
  - The end of the line is: `\t\`
  - In the project structure the folder containing the sources is: `src/`
- For the tests files:
  - The tests files are added on `TESTS\t=` variable
  - The variable containing the directory of the test files is: `TEST_SRC` a d in the line it would be: `\t$(TEST_SRC)`
  - The end of the line is: `\t\`
  - In the project structure the folder containing the tests is: `tests/`
- For the lib:
  - **The lib has her proper Makefile**
  - The files will be added to the `SRC\t=`
  - The start of the line is: `\t`
  - The end of the line is: `\t`
  - In the project structure the folder containing the lib is: `my/`

### In a nutchell
| | Folder in project structure | Varaible containing realpath | Variable containing files | Line exemple `file.c` |
|-|-|-|-|-|
| Source files | `src/` | `SRC_DIR` | `SRC\t=` | `SRC\t=\t$(SRC_DIR)/file.c\t\`|
| Test files | `tests/` | `TEST_SRC` | `TESTS\t=` | `TESTS\t=\t$(TEST_SRC)/file.c\t\` |
| Lib files | `my/` | *The files are in the root with the Makefile* | `SRC\t=` | `SRC\t=\tfile.c\t\`|

## How to use it

To use the program you are not requiered to clone the repository. If you have a Makefile that is similar to the ones on the testing/ folder. You can pull the docker image of the program:

`docker pull colcolt/makefile_completer`

And run it with the following command:

`docker run --name MakefileCompleter -d -v "$PWD:/home" --restart=always colcolt/makefile_completer`

> Once you have run your docker it will be running for ever on the background, even if you restart your computer.

**Therefore there is a script in the repository that can create the apropiate Makefile for the program**

If you clone the repository, there is a Makefile to make everything easier for you.

If we enter `make` on the command line it would build and run our docker.

For the other rules enter `make <rule>` in the command line.

The rules are:
- build *# It will build the image for you*
- run *# It will run the docker with the image pre build*
- repo_run *# It will clone the image on the Docker Hub and run the docker*
- ~~new_makefile *# It will create a Makefile based for the program*~~ *On dev*
- tests_run *# It will run some tests to see if the program is working well*
- stop *# It will stop the docker of the makefile_completer*
- re *# Use it to remake a build and re run the image docker*

> REMEMBER TO RUN THE MAKE THERE WHERE YOU WANT TO THE PROGRAM LISTEN. IT COULD NOT LISTEN ON ALL YOUR FILES, SO DO IT ONLY ON THE PARENT FOLDER OF YOUR PROJECTS.

## Contribute

If you want to contribute to the project, you need to fork this repository, add all your features and then make a pull request to the develop branch of this repository. I will review your PR as soon as possible and see if we can add the feature.

Therefore if you have an idea or a bug to report you can create a new issue and describe all in it.

### ColColty :rocket:
