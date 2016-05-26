package me::systo;
use strict;

my $prcval;

sub do_prcset {
  ($prcval) = split(/:/,$_[0]);
}
sub do_prcget {
  return $prcval;
}

sub do_prcsh {
  my $lc_modsr;
  my $lc_shel;
  my $lc_res;
  my @lc_moda;
  my $lc_modb;
  
  $lc_modsr = $prcval;
  $lc_shel = $_[0];
  $lc_res = system($lc_shel);
  if ( $lc_res < 0.5 ) { return; }
  @lc_moda = split(quotemeta('/'),$lc_modsr);
  foreach $lc_modb (@lc_moda)
  {
    if ( $lc_modb eq 'x-' ) { return; }
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
