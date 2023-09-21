ABOUT
This assignment foucsed on writing a basic conversational agent, ELIZA, written in Common LISP. 
We set rules in LISP which defined keywords and searched for them in a database we filled in.
This program would search for a certain pharse in the database, if it matched. When no matching pharse was found it would randomly select a general catch all response.
Another feature of this program it's ability to switch pronouns. We define rules for pronouns to look for and switch them from 1st person to 2nd person.

REQUIREMENTS
In order to compile the code I had to install clisp, which I did through WSL(Windows Subsystem for Linux).
My reason for it was once I had that installed I could write and test my code through VSCode instead of through the ubuntu command line
To install clisp you must go through your system's distro 

$ sudo apt update
$ sudo apt upgrade
$ sudo apt install clisp

Once this was isntalled you can compile it using 
$ clisp -i "eliza_starter.lisp"

CHATTING
Once it has been compiled using the command above, you may now start a conversation with eliza.
To converse with ELIZA you must structure your input as such:
$ (eliza '(statement))

This is because lisp takes everything in as a list. Eliza will then search your statement against the database and chooses the best response given the rules that we defined.
Keep in mind since we are the ones that setup the rules they are finite, so if a statement does not match what ELIZA has in the database the conversation may not make sense.
Also, ELIZA does not remember conversations so it will not be able to recall a previous one. 

