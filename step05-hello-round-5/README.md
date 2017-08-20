# Unit testing Hello World with Bats - Round 5

Now the script is used on a daily basis, users feel the need for improvements.

They sometimes have trouble debugging or remembreing options. They would like to have a more verbosity and a help. We have also decided to introduc switches.

> **focus of this section**
>
> - testing functions


## Specifications for Round 4

Existing specifications


- The script must output Hello x! where x stand for the name given as a parameter
- When no name is provided the script should result in errors
- Whenever the script is called without parameters or wrong parameters, it should state why the program failed and print the usage


Additional specifications

- The script must provide a way to output the usage
- The script must provide a way to print input parameters in order to debug
- Program's log lines must indicates the level (ERROR,WARN,INFO,DEBUG)


## New usage

Hello World now has the following parameters :

 - -v : increase verbosity. in verbose mode it shows the parameters' values
 - -n name : indicates the name of the person to say hello to
 - -h : display the usage

This is a major refactoring and unit tests will be a great help.

There are many changes to be done from a technical standpoint.

- most of the calls to the program will be altered due to the addition of the -n switch
- new tests are required for -h and -v
- new tests are required for -n to ensure that -h and -v does not interfere
- need some code to manage the command line options
- usage is now called from multiple places : when no argument is given, when -h is used. it must be implemented as a function
- There will be different kinds of messages and some reusable functions will be required
- new tests are required to tests functions on isolation


TODO factor usage dans le test
TODO usage sur deux lignes
TODO comment tester soit -n soit -h ?
TODO output hello sur la premiere ligne sauf si verbose et pas d'autres choses

