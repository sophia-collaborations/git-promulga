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

Now, the "main.dat" file is really just a collection of directive lines
that are gone through from beginning to end - each of them either
executed or ignored.
Everything before the first colon of each line
is called the "modal section" and determines which
mode or modes directive is applicable to.
Everything between the first and second colon of each line
is called the "activity section" and
is the directive-type - which determines what basic kind of
actions is done by that directive.
Everything after the second column
is called the "content section" and is simply the argumentation
that is passed to the directive.
Should this argumentation section contain additional colons,
the directive-type will determine whether or not those colons
have any special significance, or whether they are just
literal colons.

Every line that begins with two colons one after the other
is considered to be a comment line.

Of all the directive-types, directives of type "valid" are unique
in that it is their job to validate and activate all modes that
are specified in the.
In a sense, "valid" directives can, for this reason, be considered
to be a separate category from directives altogether - so that the lines
of the file can be categorized into "directive lines" which
contain regular directives and
"validation lines" that contain these special validation directives.
Regular directives, those found in the directive lines, will only
be executed if the mode selected by the __-md__ option is
already-validated, currently-active, and within the scope of
what is specified in the modal section of the directive line.

The modal section is a list of mode-identifiers who's items
are separated by forward-slashes.
Non-printable characters are forbidden in the modal section.
If one of these mode-identifiers is the simple wildcard character
('*') then the way it is interpreted depends on whether this is
a validation line or a directive line.
In the case of a directive line, it is interpreted as
a reference to all modes that are already-validated and currently-active.
In the case of a validation line, it applies to all modes that
are already-validated, regardless of not whether or not they are
still active.

The second section is the modal section - and non-printable characters
are illegal here too. As a matter of fact, the only thing allowed here
is the name of one valid directive-type.
If the specified directive-type is "valid", any mode (or modes)
specified in the modal section will be validated (in case they are not
already validated)
and activated (in case they are not currently active).
If the specified directive is of any other valid type,
then if the mode selected by the __-md__ option is both
active and among the modes specified in the line's modal
section, then the directive-type's implementation is run
using the contents of the content section of the line.

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
