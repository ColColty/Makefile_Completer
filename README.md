# Makefile_Completer

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
- new_makefile *# It will create a Makefile based for the program*
- tests_run *# It will run some tests to see if the program is working well*
- stop *# It will stop the docker of the makefile_completer*
- re *# Use it to remake a build and re run the image docker*

> REMEMBER TO RUN THE MAKE THERE WHERE YOU WANT TO THE PROGRAM LISTEN. IT COULD NOT LISTEN ON ALL YOUR FILES, SO DO IT ONLY ON THE PARENT FOLDER OF YOUR PROJECTS.