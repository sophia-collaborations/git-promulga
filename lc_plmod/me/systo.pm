package me::systo;
use Cwd;
use wraprg;
use strict;

my $prcval;
my $locato;

sub do_prcset {
  ($prcval) = split(/:/,$_[0]);
}
sub do_prcget {
  return $prcval;
}


sub locat_in {
  $locato = $_[0];
}
sub locat_out {
  return $locato;
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
    
    if ( $lc_modb eq 'x' )
    {
      die "\nFATAL ERROR from failed persistent command:\n\n";
    }
    
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

sub realpath {
  my $lc_a;
  $lc_a = &Cwd::abs_path($_[0]);
  if ( $lc_a eq '' ) { return $_[0]; }
  return $lc_a;
}

sub cnfread {
  my $lc_cm;
  my $lc_rs;
  $lc_cm = 'git config --local --get ';
  $lc_cm .= &wraprg::bsc($_[0]);
  $lc_rs = `$lc_cm`; chomp($lc_rs);
  if ( $lc_rs eq '' ) { $lc_rs = $_[1]; }
  return $lc_rs;
}

sub cnfwrite {
  my $lc_cm;
  $lc_cm = 'git config --local ' . &wraprg::bsc($_[0]) . ' ' . &wraprg::bsc($_[1]);
  system($lc_cm);
}


1;
