#!/usr/bin/env perl

use 5.008;
use inc::Module::Install;

warn << '.';
### PLEASE NOTE ##############################################

Note that this package is designed to be overlaid on top
of a rt3-elixus installation; all other environments are
unsupported.

You may obtain a copy of the rt3-elixus tree by checking
out from this URL, using SVK or Subversion:

    http://svn.autrijus.org/104/trunk/rt/

For SVK support, grab a copy of VCP-0.9-autrijus here:

    http://search.cpan.org/dist/VCP-autrijus-snapshot-0.9/

For Gantt chart and accountability graphs support, please
download ming_uni.ttf.gz here:

    http://info.gov.hk/digital21/chi/hkscs/download/ming_uni.ttf.gz

Extract it using "gunzip", and rename the resulting ming_uni.ttf
into this file:

    /usr/local/share/fonts/TrueType/minguni.ttf

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
    'WWW::Mechanize'            => 0,
    'Email::Address'            => 0,
    'Email::Valid'              => 0,
    'MIME::Base64'              => 0,
    'HTML::Mason'               => 0,
    'HTML::FromText'            => 0,
    'XML::RSS'                  => 0,
    'XML::Simple'               => 0,
    'Project::Gantt'            => 0,
    'HTML::CalendarMonthSimple' => 0,
    'DBIx::SearchBuilder'       => 0,
    'Template'                  => 0,
    'Image::Dot'                => 0,
);

features( 'SVK support' => [
    -default => 0,
    'Data::UUID'	    => 0,
    'VCP'		    => 0.9,
    'SVN::Simple::Edit'	    => 0,
    'SVN::Mirror'	    => 0.46,
    'SVN::Web'	            => 0,
    'SVK'		    => 0.21,
    'Proc::PID_File'	    => 0,
    'VCP::Dest::svk'	    => 0,
    'VCP::Source::cvsbk'    => 0,
    'URI'		    => 0,
    'SVN::Notify'           => 0,
    'SVN::Notify::Config'   => 0,
    'SVN::Notify::Snapshot' => 0,
] );

features( 'Accountability graphs' => [
    -default => 0,
    'GD::Graph::bars3d'     => 0,
    'Imager::Graph::Pie'    => 0,
    'FreezeThaw'            => 0,
    'Log::Accounting::SVN'  => 0,
] );

auto_install( -default => 0 );
include('ExtUtils::AutoInstall');
&WriteAll( check_nmake => 0, sign => 1 );
