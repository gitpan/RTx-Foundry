#!/usr/bin/env perl
# $File: //depot/RT/osf/Makefile.PL $ $Author: autrijus $
# $Revision: #7 $ $Change: 9904 $ $DateTime: 2004/02/04 19:02:17 $

use 5.008;
use inc::Module::Install;

warn << '.';
### PLEASE NOTE ##############################################

This is *PRE-ALPHA* code.  Using this module for anything
(except for learning purporses) is strongly discouraged.

Note that this package is designed to be overlaid on top
of a rt3-elixus (http://www.freshports.org/www/rt3-elixus/)
installation; all other environments are unsupported.

More detailed installation guides will be available in
English soon, including how to set up your RT_SiteConfig.pm
based on the sample etc/RT_SiteConfig.pm shipped here.

Meanwhile, read the "INSTALL" file for how to quickly set
up OpenFoundry on a FreeBSD system.

##############################################################
.

RTx('Foundry');
author('Autrijus Tang <autrijus@autrijus.org>');
abstract('Base classes for the OpenFoundry system');
license	('gpl');

requires(
#   'RTx::Attribute'	=> 0,
#   'RTx::TabbedUI'	=> 0,
    'WWW::Mechanize'	    => 0,
    'Email::Valid'	    => 0,
    'MIME::Base64'	    => 0,
    'HTML::Mason'	    => 0,
    'DBIx::SearchBuilder'   => 0.96,
);

features( 'SVN2CVS support' => [
    -default => 0,
    'LWP::Simple'	    => 0,
    'Digest::MD5'	    => 0,
    'File::Temp'	    => 0,
    'IPC::Run'		    => 0,
    'MIME::Base64'	    => 0,
    'Regexp::Shellish'	    => 0.93,
    'Text::Diff'	    => 0,
    'XML::ValidWriter'	    => 0.37,
    'XML::Parser'	    => 0,
    'Pod::Links'	    => 0,
] );

auto_install( -default => 0 );
include('ExtUtils/AutoInstall.pm');
&WriteAll( check_nmake => 0, sign => 1 );
