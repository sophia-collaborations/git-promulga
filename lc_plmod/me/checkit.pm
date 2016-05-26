package me::checkit;
use strict;
use me::toaction;
use me::modus;


sub cycle {
  my $lc_filca;
  my @lc_filcb;
  my $lc_filcc;
  my $lc_filok;
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
}




1;
