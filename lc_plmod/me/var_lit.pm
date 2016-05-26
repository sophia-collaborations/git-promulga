package me::var_lit;
use me::varios;
use strict;

sub do_new {
  my $lc_var;
  my $lc_dat;
  ($lc_var,$lc_dat) = split(/:/,$_[0],2);
  &me::varios::do_new($lc_var,$lc_dat);
}

sub do_add {
  my $lc_var;
  my $lc_dat;
  ($lc_var,$lc_dat) = split(/:/,$_[0],2);
  &me::varios::do_add($lc_var,$lc_dat);
}


1;
