# git-promulga
A nutbag system for advanced synchronization operations in Git.

# Overview
__git-promulga__ allows you to automate actions that are specific
to an individual clone of a __git__ repository.
Originally, it was developed to do this for tasks related to the
promulgation of changes to a program.

The very first usage of __git-promulga__ was to synchronize a
set of live web-pages with the desktop copy that was being used in their
development.
To make things even more difficult, there was the additional
requirement that the CSS style-sheets be developed in a separate
module - so that if the same pages needed to be hosted in a mirror
site, the administrator of that mirror site could easily swap out
the CSS style-sheets with an alternative more fitting of their
site.

This set of requirements would have been the source of a
perpetual administrative headache. However, thanks to
__git-promulga__, the very complex update procedure could
be configured so that all of the several steps
could be accomplished with one
relatively-simple command.

It was for such promulgation operations that __git-promulga__
was initially developed.
However, very early on,
it was discovered that it was useful for all kinds of operations
that were specific to individual clones.

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

One way to see at the documentation is
to [look at the online HTML rendition of the manual-page](http://sshapira.com/git-promulga/files/man-page.html).

Or, after installing the program, you can see the documentation on your own local
machine.
Once you have installed __git-promulga__, if you wish to read the documentation
type the following command:

    git-promulga --help

To be able to access the documentation through the __man__
user-command, then (depending on that command's defaults on
your system) you may need to enter the following litany
into your terminal
(as well as add it to your login file so that you won't
have to re-type it each session):

    MANPATH="${HOME}/share/man:${MANPATH}"
    export MANPATH
