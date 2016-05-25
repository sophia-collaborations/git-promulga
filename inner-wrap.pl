use strict;
use me::checkit;

# Set the maximum number of directories up we will try to
# go before throwing in the towel.
my $max_updir = 200;

# The default promulgation mode is 'main'
my $promlg_mode = 'main';


# Now we keep going up and up one directory at a time
# until we reach what we are looking for.
&me::checkit::cycle();
while ( $max_updir < 0.5 )
{
  chdir('..');
  &me::checkit::cycle();
  $max_updir = int($max_updir - 0.8);
}

die '
git-promulga: FATAL ERROR:
  I can not find a promulga eligible Git directory that we
  are located within. For more information type the following
  command:
      git-promulga --help

';