package RT;

Set($rtname, 'OSSF');
Set($Timezone, 'Asia/Taipei');
Set($Host, 'openfoundry.org');

Set($WebHost, "rt.$Host");
Set($CVSHost, "cvs.$Host");
Set($EmailHost, "users.$Host");
Set($DatabaseHost, "ssh.$Host");

Set($DatabaseType, 'Pg');
Set($DatabaseUser, 'pgsql');
Set($DatabasePassword, '');
Set($DatabaseRTHost, $DatabaseHost);

Set($SympaConfig, "/etc/sympa.conf");
Set($NewProjectURL, "http://$CVSHost/newproject.pl?Name=");

@EmailInputEncodings = qw(utf-8 big5 gb2312);

Set($Organization, $rtname);
Set($WebBaseURL, "http://$WebHost");
Set($TicketBaseURI, "fsck.com-rt://$RT::rtname/ticket/");
Set($RTAddressRegexp, "^rt\\\@$WebHost\$");
Set($CorrespondAddress="rt\@$WebHost");
Set($CommentAddress="rt-comment\@$WebHost");
Set($CanonicalizeEmailAddressMatch, "$WebHost\$");
Set($CanonicalizeEmailAddressReplace, $Host);

Set($LogToSyslog, '');
Set($LogDir, "$RT::VarPath/log");
Set($LogToFile, 'debug');

Set($NotifyActor, 1);
Set($HideQueueCcs, 1);
Set($ChangeOwnerUI, 1);
Set($UseCodeTickets, 1);
Set($UseFriendlyFromLine, 0);
Set($UseTransactionBatch, 1);
Set($TrustTextAttachments, 1);
Set($MinimumPasswordLength, 6);
Set($SkipEmptyTabs, 0); # set to 1 to gray out project tabs with no contents 

#use MasonX::Profiler;
#@MasonParameters = (preamble => 'my $p = MasonX::Profiler->new($m, $r);');

1;
