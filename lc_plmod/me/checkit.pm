package me::checkit;
use strict;
use me::toaction;
use me::modus;


sub cycle {
  # The first variables are applicable to the
  # function in ordinary usage (that is, even
  # in the absence of a 'continue-upward'
  # directive).
  my $lc_filca;
  my @lc_filcb;
  my $lc_filcc;
  my $lc_filok;
  
  # The following variables will only be used
  # in the event that a 'continue-upward' directive
  # is encountered.
  my $lc_cur_dir;
  my $lc_cur_mode; # The mode that was used in this round
  my $lc_rqs_mode; # The request pertaining to future mode
  my $lc_cng_mode; # 10 if mode is to change - 0 otherwise
  
  # Currently, the only check we have in place
  # for whether or not this is a Git-project
  # head-directory is this:
  if ( !(-d '.git') ) { return; }
  
  # The main promulga file must be present for
  # this to be a promulga-eligible directory.
  if ( !(-f '.promulga/main.dat') ) { return; }
  
  # Now for the heavy checks -- the promulga
  # directory must be registered in the git ignore
  # file.
  $lc_filca = `cat .gitignore`;
  @lc_filcb = split(/\n/,$lc_filca);
  $lc_filok = 0;
  foreach $lc_filcc (@lc_filcb)
  {
    if ( $lc_filcc eq '/.promulga' ) { $lc_filok = 10; }
  }
  if ( $lc_filok < 5 ) { return; }
  
  &me::modus::set_exit(10);
  &me::toaction::go();
  if ( &me::modus::get_exit() > 5 ) { exit(0); }
  
  # Okay - since we have gotten to this point without exiting
  # the program or returning to the calling function, it
  # is clear that the configuration has attached a
  # 'continue-upward' directive to the selected mode.
  # Therefore, the duration of this function is dedicated
  # to processing that directive.
  
  $lc_cur_dir = `pwd`; chomp($lc_cur_dir);
  $lc_cur_mode = &me::modus::get();
  $lc_rqs_mode = &me::modus::rqs_get();
  &me::modus::alr_on('','NOTE FROM DIRECTORY:'
    ,'  ' . $lc_cur_dir
    ,"I found a validly configured promulgation directory and processed it:"
    ,"yet due to a 'continue-upward' directive associated with the mode"
    ,"'" . $lc_cur_mode . "', the upward search for yet another so-configured directory"
    ,"continues."
  );
  
  # Now we determine if the mode is to change
  $lc_cng_mode = 10;
  if ( $lc_rqs_mode eq '*' ) { $lc_cng_mode = 0; }
  if ( $lc_rqs_mode eq $lc_cur_mode ) { $lc_cng_mode = 0; }
  
  # Finally, we change the mode if applicable.
  if ( $lc_cng_mode > 5 )
  {
    &me::modus::set($lc_rqs_mode);
    &me::modus::alr_on("The mode, however, is henceforth changed to '" . $lc_rqs_mode . "'.")
  }
}




1;
