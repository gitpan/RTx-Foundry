#!/usr/bin/env perl

use 5.008;
use inc::Module::Install;

warn << '.';
### PLEASE NOTE ##############################################

Note that this package is designed to be overlaid on top
of a rt3-elixus installation; all other environments are
unsupported.

You may obtain a copy of the rt3-elixus tree by checking
out from this URL:

    http://svn.autrijus.org/104/trunk/rt/

More detailed installation guides will be available in
English soon, including how to set up your RT_SiteConfig.pm
based on the sample etc/RT_SiteConfig.pm shipped here.

Meanwhile, read the "INSTALL" file for how to quickly set
up OpenFoundry on a FreeBSD system, from the "www/rtfoundry"
ports tarball available from:

    http://sfork.org/ports.tar.gz

##############################################################
.

RTx('Foundry');
author('Autrijus Tang <autrijus@autrijus.org>');
abstract('Base classes for the OpenFoundry system');
license ('gpl');

requires(
    'WWW::Mechanize'        => 0,
    'Email::Address'        => 0,
    'Email::Valid'          => 0,
    'MIME::Base64'          => 0,
    'HTML::Mason'           => 0,
    'XML::RSS'              => 0,
    'DBIx::SearchBuilder'   => 1.10,
);

features( 'CVS2SVN support' => [
    -default => 0,
    'LWP::Simple'           => 0,
    'Digest::MD5'           => 0,
    'File::Temp'            => 0,
    'IPC::Run'              => 0,
    'MIME::Base64'          => 0,
    'Regexp::Shellish'      => 0.93,
    'Text::Diff'            => 0,
    'XML::ValidWriter'      => 0.37,
    'XML::Parser'           => 0,
    'Pod::Links'            => 0,
] );

auto_install( -default => 0 );
include('ExtUtils::AutoInstall');
&WriteAll( check_nmake => 0, sign => 1 );
