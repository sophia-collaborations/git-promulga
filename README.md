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

Once you have done all this, if you wish to read the documentation
(that is, once the documentation is complete - and this readme
will be changed to reflact that once it is)
type the following command:

    git-promulga --help

It is important to connect the 'git' and the 'promulga' with a hyphen
in this command because, though __git-promulga__ comes with
a manual-page, it's install script does not install it -- so it
can only be viewed through the command's __--help__ option.
If you type the 'git' and the 'promulga' as separate words,
for most purposes, that will not matter -- except in the case
of the __--help__ option it will, because if you invoke the
command through __git__ then, instead of passing the __--help__
option to __git-promulga__, __git__ will simply try to process
it itself by looking up the manual-page which (though present
in the package) is not installed.
