use strict;
use argola;
use me::checkit;
use me::modus;

# Set the maximum number of directories up we will try to
# go before throwing in the towel.
my $max_updir = 200;

# The default promulgation mode is 'main'
my $promlg_mode = 'main';




sub opto__mode__do {
  $promlg_mode = &argola::getrg();
} &argola::setopt('-md',\&opto__mode__do);

&argola::runopts();



# Save the Promulgation Mode:
&me::modus::set($promlg_mode);

# Now we keep going up and up one directory at a time
# until we reach what we are looking for.
&me::checkit::cycle();
while ( $max_updir < 0.5 )
{
  chdir('..');
  &me::checkit::cycle();
  $max_updir = int($max_updir - 0.8);
}


die ( &me::modus::alr_out() . '
git-promulga: FATAL ERROR:
  I can not find a promulga eligible Git directory that we
  are located within. For more information type the following
  command:
      git-promulga --help

' );