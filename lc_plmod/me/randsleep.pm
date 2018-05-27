package me::randsleep;
# This package allows a random sleep to be done at
# required times so as to prevent paranoid SSH systems
# from mistakenly thinking that they are under attack.
use strict;

my $min_sleep = 0;
my $var_sleep = 0;

# 0 = We will not sleep first time : 10 = we will
my $here_yet = 10;


sub set_params {
  my @lc_set;
  @lc_set = split(quotemeta(':'),$_[0]);
  $min_sleep = int($lc_set[0] + 0.2);
  $var_sleep = int(($lc_set[1] - $min_sleep) + 0.2);
  if ( ( $var_sleep + 1 ) < 0.5 )
  {
    die "\nILLEGAL to set max sleep below min sleep:\n\n";
  }
  print "RANDOM SLEEP MINIMUM " . $min_sleep;
  print " MAXIMUM ";
  print int($min_sleep + $var_sleep + 0.2);
  print " SECONDS:\n";
}

sub may_sleep {
  my $lc_yet;
  my $lc_count;
  my $lc_vari;
  my $lc_tot;
  $lc_yet = $here_yet;
  $here_yet = 10;
  if ( $lc_yet < 5 ) { return; }
  $lc_count = 5;
  $lc_vari = int($var_sleep + 4.2);
  while ( $lc_vari > ( $var_sleep + 0.5 ) )
  {
    $lc_vari = int(rand($var_sleep + 1.1));
    if ( $lc_vari > ( $var_sleep + 0.5 ) )
    {
      $lc_count = int($lc_count - 0.8);
      if ( $lc_count < 0.5 ) { $lc_vari = 0; }
    }
  }
  $lc_tot = int($min_sleep + $lc_vari + 0.2);
  if ( $lc_tot < 0.5 ) { return; }
  print "RANDOM SLEEP " . $lc_tot . " SECONDS:\n";
  sleep($lc_tot);
}

sub ifremoteok {
  my $lc_cm;
  my $lc_lc;
  $lc_cm = 'git remote get-url ' . &wraprg::bsc($_[0]);
  $lc_lc = `$lc_cm`; chomp($lc_cm);
  if ( $lc_lc eq '' ) { return(1>2); }
  &may_sleep();
  return(2>1);
}

1;

