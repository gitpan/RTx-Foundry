#!/usr/bin/perl

use strict;
use DBI;

my $dbh = DBI->connect('dbi:Pg:dbname=rt3;host=ssh.openfoundry.org;user=pgsql');
my $users = $dbh->selectcol_arrayref(q{
    SELECT Users.Name
      FROM Users, GroupMembers
     WHERE Users.Password != '*NO-PASSWORD*'
       AND Users.Id = GroupMembers.MemberId
  GROUP BY Users.Name;
});

for (@$users) {
    next if defined getpwnam($_);
    system (qw(pw useradd), $_, qw(-h - -d /usr/depot/cvsrepo -u 5000 -s /bin/sh -g cvs -o));
}

$dbh->disconnect;
