package me::toaction;
use me::modus;
use strict;


my $moda;
my $validty; # 10 once mode is validated - 0 until then


sub go {
  my $lc_filca;
  my @lc_filcb;
  my $lc_filcc;
  $moda = &me::modus::get();
  $validty = 0;
  $lc_filca = `cat .promulga/main.dat`;
  @lc_filcb = split(/\n/,$lc_filca);
  foreach $lc_filcc ( @lc_filcb ) { &aline($lc_filcc); }
}

sub aline {
  my $lc_segnom;
  my $lc_segtyp;
  my $lc_segcon;
  my @lc_nomlis;
  my $lc_nomech;
  my $lc_ok; # 0 = no match ; 5 = wildcard only ; 10 = match
  ($lc_segnom,$lc_segtyp,$lc_segcon) = split(quotemeta(':'),$_[0],3);
  @lc_nomlis = split(quotemeta('/'),$lc_segnom);
  $lc_ok = 0;
  
  # First, let us make sure that that this line matches
  # the selected mode.
  foreach $lc_nomech (@lc_nomlis)
  {
    if ( $lc_nomech eq '*' ) { if ( $lc_ok < 5 ) { $lc_ok = 5; } }
    if ( $lc_nomech eq $moda ) { $lc_ok = 10; }
  }
  if ( $lc_ok < 3 ) { return; }
  
  # Validation by wildcard is illegal.
  if ( $lc_segtyp eq 'valid' )
  {
    if ( $lc_ok > 7 ) { $validty = 10; }
    return;
  }
  
  # Validation is the only kind of operation that may
  # be done if the mode in question hasn't already been
  # validated.
  if ( $validty < 5 ) { return; }
  
  # Next -- for simple shell commands:
  if ( $lc_segtyp eq 'sh' )
  {
    system($lc_segcon);
    return;
  }
  
  # Now a directive to concisely commit all changes:
  if ( $lc_segtyp eq 'commit' )
  {
    system("git add --all");
    system("git commit");
    return;
  }
  
  # Now, a directive for when promulgation here implies
  # also some promulgation of a directory higher up in
  # the tree.
  if ( $lc_segtyp eq 'continue-upward' )
  {
    my $lc2_mode;
    ($lc2_mode) = split(/:/,$lc_segcon);
    &me::modus::set_exit(0); # Cancel the exit
    &me::modus::rqs_set($lc2_mode); # Make the mode-request
    return;
  }
  
}


1;
