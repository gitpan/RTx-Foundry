#!/usr/bin/env perl
# $File: //depot/RT/osf/Makefile.PL $ $Author: autrijus $
# $Revision: #2 $ $Change: 8883 $ $DateTime: 2003/11/15 05:11:21 $

use 5.008;
use inc::Module::Install;

warn << '.';
### PLEASE NOTE ##############################################

This is *PRE-ALPHA* code.  Using this module for anything
(except for learning purporses) is strongly discouraged.

Currently, "make install" does not really do anything, since
this package is designed to be overlaid on top of a rt3-elixus
(http://www.freshports.org/www/rt3-elixus/) installation.

More detailed installation guides will be available soon.

##############################################################
.

# XXX - figure out how to install po/ and html/

author		('Autrijus Tang (autrijus@autrijus.org)');
name		('RTx-Foundry');
abstract	('Base classes for the OpenFoundry system');
version_from	('lib/RTx/Foundry.pm');
requires	(
    'RTx::Attribute'	=> 0,
    'RTx::TabbedUI'	=> 0,
    'WWW::Mechanize'	=> 0,
    'Email::Valid'	=> 0,
    'MIME::Base64'	=> 0,
    'HTML::Mason'	=> 0,
);

recommends	(
    'VCP'		=> 0,
    'SVN::Core'		=> 0,
#   'MasonX::Profiler'	=> 0,
);

sign		(1);
license		('gpl');
no_index	( directory => 'html' );

&Meta->write;
&Makefile->write;
