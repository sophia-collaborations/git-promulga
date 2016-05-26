package me::varios;
use strict;

my %vrhsh = {};

sub do_new {
  $vrhsh{$_[0]} = ( $_[1] . '\n' );
}

sub do_add {
  my $lc_ix;
  $lc_ix = $vrhsh{$_[0]};
  $vrhsh{$_[0]} = ( $lc_ix . $_[1] . '\n' );
}

sub do_get {
  return $vrhsh{$_[0]};
}


1;
