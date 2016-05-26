package me::modus;
use strict;

my $mod_set; # The current mode in which the program is running
my $mod_rqs; # A place for 'continue-upward' directives to request mode
my $strbrnc; # The branch we start out with
my $alrt = '';
my $exitor; # 10 if exit upon processing - 0 otherwise:
my @remotes; # The list of remotes currently interacted with

sub set {
  $mod_set = $_[0];
}

sub get {
  return $mod_set;
}

sub brnc_fnd {
  # This function should be called at the start of the
  # processing of a project's head-directory and only
  # then - to find out what branch the project starts
  # at and register that information.
  $strbrnc = &brnc_id();
  return $strbrnc;
}

sub brnc_id {
  # This function identifies at any given time what
  # branch we are presently on. The reason it was
  # separated from the rest of &brnc_fnd() is because
  # it is needed at times to assess the success of
  # branch-swapping operations.
  my $lc_a;
  $lc_a = `git rev-parse --abbrev-ref HEAD`;
  chomp($lc_a);
  return $lc_a;
}

sub brnc_get {
  return $strbrnc;
}

sub brnc_trp {
  if ( $_[0] eq '*' ) { return $strbrnc; }
  return $_[0];
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

sub remote_set_cm {
  my @lc_raw;
  my @lc_nrw;
  my $lc_ech;
  @lc_raw = split(/:/,$_[0]);
  @lc_nrw = ();
  foreach $lc_ech (@lc_raw)
  {
    if ( $lc_ech ne '' ) { @lc_nrw = (@lc_nrw,$lc_ech); }
  }
  @remotes = @lc_nrw;
  return @lc_nrw;
}

sub remote_get {
  return @remotes;
}


1;
