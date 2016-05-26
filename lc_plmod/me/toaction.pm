package me::toaction;
use wraprg;
use me::modus;
use me::var_lit;
use me::brancha;
use me::systo;
use strict;


my $moda;
my $validty; # 10 once mode is validated - 0 until then


sub go {
  my $lc_filca;
  my @lc_filcb;
  my $lc_filcc;
  
  # We must know what mode we are on:
  $moda = &me::modus::get();
  
  # We must know what branch this clone is on
  # to start with:
  &me::modus::brnc_fnd();
  
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
  # Or, for persistent shell-commands:
  if ( $lc_segtyp eq 'prcsh' ) { &me::systo::do_prcsh($lc_segcon); return; }
  
  # Now a directive to concisely commit all changes:
  if ( $lc_segtyp eq 'commit' )
  {
    system("git reset");
    system("git add --all");
    system("git commit");
    system("git reset");
    return;
  }
  
  # Now a directive to change what branch you are on.
  if ( $lc_segtyp eq 'branch' )
  {
    my $lc2_mod;
    my $lc2_segcon;
    my @lc2_segls;
    my $lc2_sege;
    my $lc2_now;
    ($lc2_mod,$lc2_segcon) = split(/:/,$lc_segcon,2);
    $lc2_mod = &me::modus::brnc_trp($lc2_mod);
    
    # First, the basic mode-swapping:
    system(('git checkout ' . &wraprg::bsc($lc2_mod) . ' --'));
    
    # Now for the options:
    @lc2_segls = split(/:/,$lc2_segcon);
    foreach $lc2_sege (@lc2_segls)
    {
      # This option makes it a fatal-error if the branch
      # switching directive is not successful.
      if ( $lc2_sege eq 'die' )
      {
        $lc2_now = &me::modus::brnc_id();
        if ( $lc2_now ne $lc2_mod )
        {
          die ('
git-promulga: FATAL ERROR:
    Could not switch to Git branch: ' . $lc2_mod . ':

')
          ;
        }
      }
      
      # This option attempts to force the creation of the
      # desired branch if the initial attempt to switch
      # to it is not successful.
      if ( $lc2_sege eq 'frc' )
      {
        $lc2_now = &me::modus::brnc_id();
        if ( $lc2_now ne $lc2_mod )
        {
          system(('git checkout -b ' . &wraprg::bsc($lc2_mod)));
        }
      }
    }
    return;
  }
  
  # Now two directives for writing variables literally:
  if ( $lc_segtyp eq 'lit-new' ) { &me::var_lit::do_new($lc_segcon); return; }
  if ( $lc_segtyp eq 'lit-add' ) { &me::var_lit::do_add($lc_segcon); return; }
  
  # To set the remotes we currently interact with:
  if ( $lc_segtyp eq 'remotes' ) { &me::modus::remote_set_cm($lc_segcon); return; }
  
  # To merge various branches:
  if ( $lc_segtyp eq 'merge' ) { &me::brancha::do_merge($lc_segcon); return; }
  # And sync them with the remotes
  if ( $lc_segtyp eq 'pull' ) { &me::brancha::do_pull($lc_segcon); return; }
  if ( $lc_segtyp eq 'push' ) { &me::brancha::do_push($lc_segcon); return; }
  if ( $lc_segtyp eq 'prcpull' ) { &me::brancha::do_prc_pull($lc_segcon); return; }
  if ( $lc_segtyp eq 'prcpush' ) { &me::brancha::do_prc_push($lc_segcon); return; }
  
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
