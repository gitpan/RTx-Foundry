package RT;

Set($rtname, "rt.openfoundry.org");
Set($Organization, "rt.openfoundry.org");
Set($Timezone, 'Asia/Taipei');

Set($WebUser, 'www');
Set($WebGroup, 'www');

Set($LogDir, "/usr/local/rt3/var/log");
Set($OwnerEmail, 'root');

Set($RTAddressRegexp, '^rt\@rt.openfoundry.org$');

Set($CanonicalizeEmailAddressMatch, 'rt.openfoundry.org$');
Set($CanonicalizeEmailAddressReplace, 'openfoundry.org');

Set($CorrespondAddress='rt@rt.openfoundry.org');
Set($CommentAddress='rt-comment@rt.openfoundry.org');

Set($MailCommand, 'sendmailpipe');
Set($SendmailPath, "/usr/sbin/sendmail");

#Set($MailCommand, 'smtp');
#Set($SMTPServer, "localhost");
#Set($SMTPFrom, "rt\@rt.openfoundry.org");
#Set($SMTPDebug, 1);

Set($LogToSyslog, '');
Set($LogToScreen, 'error');
Set($LogToFile, 'debug');
Set($LogToFileNamed, "rt.log"); #log to rt.log.<pid>.<user>

Set($WebBaseURL, "http://rt.openfoundry.org");
Set($TicketBaseURI, "openfoundry.org-rt://$Organization/$rtname/ticket/");

@EmailInputEncodings = qw(utf-8 big5 gb2312);
Set($EmailOutputEncoding, 'utf-8');

Set($WebExternalAuth, 0);
Set($WebFallbackToInternalAuth, 0);
Set($WebExternalAuto, 1);

Set($DatabaseType, 'Pg');
Set($DatabaseHost, 'ssh.openfoundry.org');
Set($DatabaseRTHost, 'ssh.openfoundry.org');
Set($DatabaseUser, 'pgsql');
Set($TrustTextAttachments, 1);
Set($ChangeOwnerUI, 1);
Set($NotifyActor, 1);
Set($MinimumPasswordLength, 6);
Set($NewProjectURL, "http://cvs.openfoundry.org/newproject.pl?Name=");
Set($UseFriendlyFromLine, 0); # don't leak real names

Set($UseCodeTickets, 1);
Set($UseTransactionBatch, 1);

#use MasonX::Profiler;
#@MasonParameters = (preamble => 'my $p = MasonX::Profiler->new($m, $r);');

1;
