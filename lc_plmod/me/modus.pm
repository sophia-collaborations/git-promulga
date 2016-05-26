package me::modus;
use strict;

my $mod_set;
my $alrt = '';
my $exitor; # 10 if exit upon processing - 0 otherwise:

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

sub set_exit {
  $exitor = $_[0];
}

sub get_exit {
  return $exitor;
}


1;
