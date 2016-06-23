# git-promulga
A nutbag system for advanced synchronization operations in Git.

# Installation
Before you install, make sure that you have your account configured
in such a way that the 'bin' subdirectory of your home directory
is on your execution path. Then, if necessary, log-out and log
back in - for the changes to take effect.

Next, create an empty directory where you will permanently store
files associated with this program.
In the terminal, enter that directory, and then type
the following litany:

    # Installing the prerequisite -chobakwrap- infrastructure:
    git clone https://github.com/sophia-collaborations/chobakwrap.git
    ( cd chobakwrap && (
      sh install.sh
    ) )
    # Installing -git-promulga- itself:
    git clone https://github.com/sophia-collaborations/git-promulga.git
    ( cd git-promulga && (
      sh install.sh
    ) )

Later, when it is time to update the software, then
from the same directory that you entered the previous litany,
enter the following litany.

    # Updating the prerequisite -chobakwrap- infrastructure:
    ( cd chobakwrap && (
      git pull origin master
      sh install.sh
    ) )
    # Updating -git-promulga- itself:
    ( cd git-promulga && (
      git pull origin master
      sh install.sh
    ) )

Documentation is not complete - but it is far enough along
that you should be able to use it to do a reasonable amount
of useful stuff with __git-promulga__.

To be able to access the documentation through the __man__
user-command, then (depending on that command's defaults on
your system) you may need to enter the following litany
into your terminal
(as well as add it to your login file so that you won't
have to re-type it each session):

    MANPATH="${HOME}/share/man:${MANPATH}"
    export MANPATH

Once you have installed __git-promulga__, if you wish to read the documentation
type the following command:

    git-promulga --help
