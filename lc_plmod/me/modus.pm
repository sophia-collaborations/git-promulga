package me::modus;
use strict;

my $mod_set; # The current mode in which the program is running
my $mod_rqs; # A place for 'continue-upward' directives to request mode
my $alrt = '';
my $exitor; # 10 if exit upon processing - 0 otherwise:

sub set {
  $mod_set = $_[0];
}

sub get {
  return $mod_set;
}

sub rqs_set {
  $mod_rqs = $_[0];
}

sub rqs_get {
  return $mod_rqs;
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
