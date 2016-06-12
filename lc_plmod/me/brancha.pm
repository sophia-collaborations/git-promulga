package me::brancha;
use me::modus;
use me::systo;
use wraprg;
use strict;

sub do_impose {
  my @lc_zet;
  my $lc_a;
  
  @lc_zet = split(/:/,$_[0]);
  &me::systo::do_prcsh("git checkout " . &wraprg::bsc($lc_zet[0]) . " --");
  $lc_a = `git rev-parse HEAD`; chomp($lc_a);
  &me::systo::do_prcsh("git checkout " . &wraprg::bsc($lc_zet[1]) . " --");
  system("git","reset","--hard",$lc_a);
}

sub do_merge {
  my $lc_last;
  my $lc_lsta;
  my @lc_brgo;
  my $lc_raw;
  my $lc_act;
  ($lc_last,$lc_lsta) = split(/:/,$_[0],2);
  $lc_last = &me::modus::brnc_trp($lc_last);
  @lc_brgo = split(/:/,$lc_lsta);
  foreach $lc_raw (@lc_brgo)
  {
    $lc_act = &me::modus::brnc_trp($lc_raw);
    system('git checkout ' . &wraprg::bsc($lc_act) . ' --');
    if ( $lc_act ne $lc_last )
    {
      if ( $lc_act ne '' )
      {
        if ( $lc_act ne &me::modus::brnc_id() )
        {
          system('git checkout --orphan ' . &wraprg::bsc($lc_act));
        }
        system('git merge ' . &wraprg::bsc($lc_last));
        $lc_last = $lc_act;
      }
    }
  }
}

sub do_pull {
  my $lc_a;
  $lc_a = &me::systo::do_prcget();
  &me::systo::do_prcset('x-');
  &do_prc_pull($_[0]);
  &me::systo::do_prcset($lc_a);
}

sub do_prc_pull {
  my @lc_list;
  my @lc_remos;
  my $lc_e_br_a;
  my $lc_e_br_r;
  my $lc_e_rm;
  @lc_list = split(/:/,$_[0]);
  @lc_remos = &me::modus::remote_get();
  foreach $lc_e_br_a (@lc_list)
  {
    $lc_e_br_r = &me::modus::brnc_trp($lc_e_br_a);
    if ( $lc_e_br_r ne '' )
    {
      system('git checkout ' . &wraprg::bsc($lc_e_br_r) . ' --');
      if ( $lc_e_br_r ne &me::modus::brnc_id() )
      {
        system('git checkout --orphan ' . &wraprg::bsc($lc_e_br_r));
      }
      foreach $lc_e_rm (@lc_remos)
      {
        #&me::systo::do_prcsh_ftl('git pull ' . &wraprg::bsc($lc_e_rm) . ' ' . &wraprg::bsc($lc_e_br_r));
        &do_xa_prc_act('pull',$lc_e_rm,$lc_e_br_r);
      }
    }
  }
}

sub do_xa_prc_pull {
  my $lc_loksta;
  $lc_loksta = $ENV{'GIT_PROMULGA_DIR'};
  my $lc_cm;
  $lc_loksta = $ENV{'GIT_PROMULGA_DIR'};
  $lc_loksta .= '/spcl/scrt';
  system("echo",$lc_loksta); sleep(5);
  system("git",@_);
}

sub do_push {
  my $lc_a;
  $lc_a = &me::systo::do_prcget();
  &me::systo::do_prcset('x-');
  &do_prc_push($_[0]);
  &me::systo::do_prcset($lc_a);
}

sub do_prc_push {
  my @lc_list;
  my @lc_remos;
  my $lc_e_br_a;
  my $lc_e_br_r;
  my $lc_e_rm;
  @lc_list = split(/:/,$_[0]);
  @lc_remos = &me::modus::remote_get();
  foreach $lc_e_br_a (@lc_list)
  {
    $lc_e_br_r = &me::modus::brnc_trp($lc_e_br_a);
    if ( $lc_e_br_r ne '' )
    {
      system('git checkout ' . &wraprg::bsc($lc_e_br_r) . ' --');
      if ( $lc_e_br_r eq &me::modus::brnc_id() )
      {
        foreach $lc_e_rm (@lc_remos)
        {
          &me::systo::do_prcsh('git push ' . &wraprg::bsc($lc_e_rm) . ' ' . &wraprg::bsc($lc_e_br_r));
        }
      }
    }
  }
}


1;
