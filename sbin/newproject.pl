#!/usr/local/bin/perl

use CGI qw/:standard/;
use File::Copy;

print header();

my $name = param('Name') or exit;
$name = lc($name);
$name =~ /^[a-z][0-9a-z]{2,14}$/ or exit;

mkdir "/usr/depot/cvsrepo/$name";
chmod(0777, "/usr/depot/cvsrepo/$name");

unless (-d "/home/svn-repositories/$name") {
    system("svnadmin create /home/svn-repositories/$name");
    copy("/home/svn-repositories/start-commit", "/home/svn-repositories/$name/hooks/start-commit");
    copy("/home/svn-repositories/pre-revprop-change", "/home/svn-repositories/$name/hooks/pre-revprop-change");
    chmod(0755, "/home/svn-repositories/$name/hooks/start-commit");
    chmod(0755, "/home/svn-repositories/$name/hooks/pre-revprop-change");
}

print "OK";
