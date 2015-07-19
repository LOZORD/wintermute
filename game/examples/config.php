<?php
    ////////////////////////////////////////
    //  Phaser Debug Runner Configuration //
    ////////////////////////////////////////

    //  This is an array of local hosts that your machine may be identified as
    //  If you run under a different IP address add it to this list
    $config_hosts = array('192.168.0.100', 'localhost', 'examples.phaser.dev');

    //  You must have the Phaser repository checked out locally as well
    //  This is the path to it. It can be relative to this file or an absolute path.
    $config_phaser_path = '../../phaser';

    //  The Debug Runner was designed for testing the Phaser dev branch.
    //  However you can switch it from testing direct from source to 
    //  testing a pre-built Phaser JS file instead. Specify here the
    //  filename it should switch to (file must exist in the examples/_site/phaser folder)
    $config_phaser_min = 'phaser.2.3.0.min.js';
    // $config_phaser_min = 'phaser.2.4.0.js';

?>