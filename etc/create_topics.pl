#!/usr/local/bin/perl
use strict;

use lib qw(/opt/rt3/local/lib /opt/rt3/lib);
use RT;
use RT::Interface::CLI qw(CleanEnv GetCurrentUser GetMessageContent loc);
CleanEnv(); RT::LoadConfig(); RT::Init(); RT::DropSetGIDPermissions();

use RT::Queue;
use RT::Queues;
use RT::CustomField;
use RT::CustomFieldValue;

open OUT, '>/home/sympa/bin/etc/topics.conf' or die $!;

my $Queues = RT::Queues->new($RT::SystemUser);
$Queues->LimitToEnabled;
$Queues->OrderBy( FIELD => 'Name', ORDER => 'ASC' );
while (my $QueueObj = $Queues->Next) {
    print OUT
	  $QueueObj->OriginObj->CustomFieldValue('UnixName'), $/,
	  "title ", $QueueObj->Name, $/,
	  "visibility noconceal\n\n";
}

close OUT;
