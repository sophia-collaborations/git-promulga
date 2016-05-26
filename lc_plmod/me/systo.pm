package me::systo;
use strict;


sub do_prcsh {
  my $lc_modsr;
  my $lc_shel;
  my $lc_res;
  my @lc_moda;
  my $lc_modb;
  
  ($lc_modsr,$lc_shel) = split(/:/,$_[0],2);
  $lc_res = system($lc_shel);
  if ( $lc_res < 0.5 ) { return; }
  @lc_moda = split(quotemeta('/'),$lc_modsr);
  foreach $lc_modb (@lc_moda)
  {
    &aswesleep($lc_modb);
    
    system("echo","TRYING AGAIN: " . $lc_shel);
    $lc_res = system($lc_shel);
    if ( $lc_res < 0.5 ) { return; }
  }
}

sub aswesleep {
  system("echo","Awaiting Retry: " . $_[0]);
  sleep($_[0]);
}


1;
