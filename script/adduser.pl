#!/usr/local/bin/perl

use Tie::DBI;

while (1) {
    foreach my $file (</var/spool/openfoundry/newuser.*>) {
	open my $fh, '<', $file or die $!;
	my ($user, $pwd) = <$fh>;
	chomp $user; chomp $pwd;
	if ($user and $pwd) {
	    system(qw(pw useradd), $user, qw(-h - -d /osf/cvs -s /bin/sh -g cvsonly));
	    tie my %h, 'Tie::DBI', 'Pg:dbname=system;host=ssh.openfoundry.org;user=pgsql', 'auth', 'id', { CLOBBER => 1 } or die DBI->errstr;
	    $h{$user} = { passwd => $pwd };
	    untie %h;
	}
	close $fh;
	unlink $file;
    }
    sleep 60;
}
