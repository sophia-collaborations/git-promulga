package me::modus;
use strict;

my $mod_set;
my $alrt = '';

sub set {
  $mod_set = $_[0];
}

sub get {
  return $mod_set;
}

sub alr_on {
  my $lc_rg;
  foreach $lc_rg (@_)
  {
    $alrt .= $lc_rg . "\n";
  }
}

sub alr_out {
  return $alrt;
}


1;
