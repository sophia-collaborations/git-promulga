package me::checkit;
use strict;
use chobak_warnerr;
use me::toaction;
use me::modus;
use me::systo;


sub cycle {
  # The first variables are applicable to the
  # function in ordinary usage (that is, even
  # in the absence of a 'continue-upward'
  # directive).
  my $lc_filca;
  my @lc_filcb;
  my $lc_filcc;
  my $lc_filok;
  my $lc_awinner;
  my $lc_pwad;
  
  # The following variables will only be used
  # in the event that a 'continue-upward' directive
  # is encountered.
  my $lc_cur_dir;
  my $lc_cur_mode; # The mode that was used in this round
  my $lc_rqs_mode; # The request pertaining to future mode
  my $lc_cng_mode; # 10 if mode is to change - 0 otherwise
  
  # Currently, the only check we have in place
  # for whether or not this is a Git-project
  # head-directory is this:
  #   THIS CRITERION APPLIES TO BOTH MODES OF
  # SELECTING THE CONFIGURATION DIRECTORY.
  if ( !(-d '.git') ) { return; }
  
  $lc_awinner = 0;
  
  
  # NOW FOR THE NEWER MODE OF CONFIGURATION-LOCATION:
  if ( $lc_awinner < 5 )
  {
    $lc_awinner = 10;
    
    my $lc2_loc;
    my $lc2_lcf;
    $lc2_loc = &me::systo::cnfread('promulga.dir','x');
    if ( $lc2_loc eq 'x' ) { $lc_awinner = 0; }
    
    if ( $lc_awinner > 5 )
    {
      $lc2_lcf = ( $lc2_loc . '/main.dat' );
      if ( ! ( -f $lc2_lcf ) ) { $lc_awinner = 0; }
    }
    
    # No need to check for registration in .gitignore because
    # this directory is most-likely outside the repository.
    
    if ( $lc_awinner > 5 )
    {
      $ENV{'GIT_PROMULGA_DIR'} = $lc2_loc;
    }
  }
  
  
  # NOW FOR THE OLD-FASHIONED MODE OF CONFIGURATION:
  if ( $lc_awinner < 5 )
  {
    $lc_awinner = 10;
    
    # The main promulga file must be present for
    # this to be a promulga-eligible directory.
    if ( !(-f '.promulga/main.dat') ) { $lc_awinner = 0; }
    
    # Now for the heavy checks -- the promulga
    # directory must be registered in the git ignore
    # file.
    if ( $lc_awinner > 5 )
    {
      $lc_filca = `cat .gitignore`;
      @lc_filcb = split(/\n/,$lc_filca);
      $lc_filok = 0;
      foreach $lc_filcc (@lc_filcb)
      {
        if ( $lc_filcc eq '/.promulga' ) { $lc_filok = 10; }
      }
      if ( $lc_filok < 5 ) { return; }
    }
    
    if ( $lc_awinner > 5 )
    {
      # Now we will set the value for GIT_PROMULGA_DIR
      {
        my $lc2_a;
        $lc2_a = `pwd`; chomp($lc2_a);
        $lc2_a .= '/.promulga';
        $ENV{'GIT_PROMULGA_DIR'} = $lc2_a;
      }
      $lc_pwad = `pwd`; chomp($lc_pwad);
      &chobak_warnerr::prima_one(
        "\ngit-promulga: DEPRECATION WARNING:\n" .
          "    DIRECTORY: " . $lc_pwad . ":\n" .
          "The use of internal configuration directories in git-promulga has been\n" .
          "deprecated and support for it will be discontinued at High Noon\n" .
          "on July 4, 2017. Until that time, this warning will be accompanied\n" .
          "by a pause of gradually increasing duration as to make sure that\n" .
          "developers see the warning so that they can heed it.\n" .
          "  Move the configuration directory to a place in your filesystem\n" .
          "that is outside of your repository - and then use the '-cnf' option\n" .
          "of 'git-promulga' to set it as your external configuration directory.\n" .
        "\n",
        "\ngit-promulga: FATAL ERROR:\n" .
          "    DIRECTORY: " . $lc_pwad . ":\n" .
          "The use of internal configuration directories in git-promulga has been\n" .
          "deprecated and support for it has been discontinued\n" .
          "  Move the configuration directory to a place in your filesystem\n" .
          "that is outside of your repository - and then use the '-cnf' option\n" .
          "of 'git-promulga' to set it as your external configuration directory.\n" .
        "\n",
        '2016-07-04--12-00-00',
        20,
        '2017-07-04--12-00-00'
      );
    }
  }
  
  # IF NO MODE SUCCEEDS, WE FAIL.
  if ( $lc_awinner < 5 ) { return; }
  
  # Now for the unique identifier:
  {
    my $lc2_a;
    $lc2_a = &me::systo::cnfread('promulga.repoid','solo');
    $ENV{'GIT_PROMULGA_RPID'} = $lc2_a;
  }
  
  &me::modus::set_exit(10);
  &me::toaction::go();
  if ( &me::modus::get_exit() > 5 ) { exit(0); }
  
  # Okay - since we have gotten to this point without exiting
  # the program or returning to the calling function, it
  # is clear that the configuration has attached a
  # 'continue-upward' directive to the selected mode.
  # Therefore, the duration of this function is dedicated
  # to processing that directive.
  
  $lc_cur_dir = `pwd`; chomp($lc_cur_dir);
  $lc_cur_mode = &me::modus::get();
  $lc_rqs_mode = &me::modus::rqs_get();
  &me::modus::alr_on('','NOTE FROM DIRECTORY:'
    ,'  ' . $lc_cur_dir
    ,"I found a validly configured promulgation directory and processed it:"
    ,"yet due to a 'continue-upward' directive associated with the mode"
    ,"'" . $lc_cur_mode . "', the upward search for yet another so-configured directory"
    ,"continues."
  );
  
  # Now we determine if the mode is to change
  $lc_cng_mode = 10;
  if ( $lc_rqs_mode eq '*' ) { $lc_cng_mode = 0; }
  if ( $lc_rqs_mode eq $lc_cur_mode ) { $lc_cng_mode = 0; }
  
  # Finally, we change the mode if applicable.
  if ( $lc_cng_mode > 5 )
  {
    &me::modus::set($lc_rqs_mode);
    &me::modus::alr_on("The mode, however, is henceforth changed to '" . $lc_rqs_mode . "'.")
  }
}




1;
