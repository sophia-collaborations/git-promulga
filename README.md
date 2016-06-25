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

# Usage

## The Basics
If you wish to use __git-promulga__ on a particular clone of a project, the first thing you
have to do is link it to a configuration directory. You do this with the __-cnf__ option
with a command like the following that must be called from inside your local clone
of the repository:

    git-promulga -cnf <directory> <identifier>

In this command, "<directory>" must be replaced by the the location of the
configuration directory, and "<identifier>" by a string that uniquely identifies
that repository to said configuration directory. (To be safe, make sure that
the identifier only has alphanumeric character, hyphens, and underscores.)
The configuration directory should _not_ be at any location that the
repository tracks - and should preferably
be in a place of your filesystem that is clearly outside your git repository.

For a directory to be considered to be a valid configuration directory by __git-promulga__, it must
have inside it a file called "main.dat". Aside from the "main.dat", the only contents of the configuration
directory that have any special significance to __git-promulga__ are the contents of the directory named "spcl"
if there exists such a directory inside the configuration directory (which, for now, really just means
that "spcl" is reserved for later versions). However, aside from the "main.dat" file and the "spcl" directory,
the rest of the configuration directory may be used as a place to store whatever resources these
resources are configured to require.

Obviously, you will get a fatal error if you specify a directory that is not a valid configuration
directory. However, once you have linked the repository to such a directory, you will not need
to do so again unless there is a change in where the configuration directory of that repository
needs to be re-located - or unless you erase and re-clone the repository.

Once linked to a configuration directory, you can run __git-promulga__ by typing the following
command from within the repository:

    git-promulga -md <mode>

In this command, "<mode>" needs to be replaced by the mode identifier -
which is a string that is used to determine which directives inside the
"main.dat" file get executed.
The manual page has a more complete explanation of which characters
are legal in a mode identifier - but as long as you stick to
alphanumeric characters, you're pretty much safe.

The default mode is "main" - which means that if you type ...

    git-promulga

... that will be the same as if you type:

    git-promulga -md main

## Further Documentation
Documentation is not complete - but it is far enough along
that by reading the manual page, you should be able to learn enough to do
most-anything of which __git-promulga__ is capable.

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
