use strict;
use argola;
use me::checkit;
use me::modus;
use me::systo;

# Set the maximum number of directories up we will try to
# go before throwing in the towel.
my $max_updir = 200;

# The default promulgation mode is 'main'
my $promlg_mode = 'main';




sub opto__mode__do {
  $promlg_mode = &argola::getrg();
} &argola::setopt('-md',\&opto__mode__do);

sub opto__cnf_do {
  my $lc_rga;
  my $lc_rgb;
  my $lc_cfile;
  
  $lc_rga = &argola::getrg();
  $lc_rgb = &argola::getrg();
  if ( &argola::yet() ) {
    die "\ngit-promulga: FATAL ERROR:\n" .
      "  Too many arguments following the -cnf option.\n" .
    "\n";
  }
  $lc_rga = &me::systo::realpath($lc_rga);
  
  $lc_cfile = $lc_rga . '/main.dat';
  
  if ( ! ( -f $lc_cfile ) )
  {
    die "\ngit-promulga: FATAL ERROR:\n" .
      "  Bad config directory:\n      " . $lc_rga . ":\n" .
      "  It does not contain the obligatory \"main.dat\" file.\n" .
    "\n";
  }
  
  &me::systo::cnfwrite('promulga.dir',$lc_rga);
  &me::systo::cnfwrite('promulga.repoid',$lc_rgb);
  
  exit(0);
} &argola::setopt('-cnf',\&opto__cnf_do);



&argola::help_opt('--help','help/git-promulga.1');

&argola::runopts();



# Save the Promulgation Mode:
&me::modus::set($promlg_mode);

# Now we keep going up and up one directory at a time
# until we reach what we are looking for.
&me::checkit::cycle();
while ( $max_updir > 0.5 )
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