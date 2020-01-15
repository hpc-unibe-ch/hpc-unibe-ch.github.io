# Installing Custom Software

## Description

UBELIX comes with a plethora of software pre-installed. You can find a list of already available software [here](pre-installed-software.html). If needed, every user can install custom software within his home directory. You cannot use the packet management utility yum for this, since this command requires root privileges to install software system wide. Instead you have to compile and install the software yourself. If you think that some missing software could be of general interest for the UBELIX community, you can ask us to install the software system wide. Since maintaining software is a lot of work, we will select carefully which software we will install globally.


## Compile and Install Custom Software
With Linux, you typically compile, link, and install a program like this:

```Bash
$ tar xzvf some-software-0.1.tar.gz
$ cd some-software-0.1
$ ./configure --prefix=$HOME/my_custom_software/some-software
$ make
$ make install
$ make clean
```

**configure** is usually a complex shell script that gathers information about your system and makes sure that everything needed for compiling the program is available. It may also create a Makefile that is used by the **make** command. With the --prefix option you can specify a base directory, relative to which **make install** will install the files. The make utility is what does the actual compiling and linking. If for example some additional library is missing on the system or not found in the expected location, the command will normally exit immediately. make install puts the compiled files in the proper directories (e.g. $HOME/my_custom_software/some-software/bin, $HOME/my_custom_software/some-software/lib, ...). **make clean** cleans up temporary files that were generated during the compiling and linking stage.

## Further Information

GNU make documentation (advanced): [http://www.gnu.org/software/make/manual/make.html](http://www.gnu.org/software/make/manual/make.html)

**_Realted pages:_**

* [Installing Custom Software](installing-custom-software.html)
* [Pre-Installed Software](pre-installed-software.html)
* [R](r.html)

