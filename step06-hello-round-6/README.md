# Unit testing Hello World with Bats - Round 6


Users are very happy with the tool. They were no bugs found so far. The script has been presented in a local user group and gained a lot of attention.

Now it is serious game. This program must have a help function. And also users have reported they want the traces and errors to be reported on standard error and with a line pattern including the severity of the message.


> **focus of this section**
>
> - refactoring of code
> - testing functions

## Specifications for Round 5

Existing specifications

- The script must output Hello x! where x stand for the name given as a parameter
- When no name is provided the script should result in errors
- Whenever the script is called without parameters or wrong parameters, it should state why the program failed and print the usage
- The script must provide a way to print input parameters in order to debug
- There must be a way to set on/off the verbosity


Additional specifications

- The script must provide a usage to helping users
- Errors and trace must go to the standard error stream
- The severity of the message (ERROR,WARN,INFO,DEBUG) must be added at the beginning of the message

## New usage

Hello World now has the following parameters :

 - -v : increase verbosity. in verbose mode  parameters' values will show up
 - -n name : indicates the name of the person to say hello to
 - -h : display the usage

There are many changes to be done from a technical standpoint.

- new tests are required for  -h
- usage is now called from multiple places : when no argument is given, when -h is used. it must be implemented as a function
- messages are formatted and some reusable functions will be required to ease implementation
- new tests are required to tests functions on isolation



TODO factor usage dans le test
TODO usage sur deux lignes
TODO comment tester soit -n soit -h ?
TODO output hello sur la premiere ligne sauf si verbose et pas d'autres choses



