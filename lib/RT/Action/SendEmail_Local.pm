# $File: //depot/RT/osf/lib/RT/Action/SendEmail_Local.pm $ $Author: autrijus $
# $Revision: #2 $ $Change: 9137 $ $DateTime: 2003/12/05 19:48:10 $

use strict;
no warnings 'redefine';

sub SetSubjectToken {
    my $self = shift;
    my $QueueObj = $self->TicketObj->QueueObj;
    my $id = $self->TicketObj->id;
    my $tag = sprintf(
	"[%s:%s #%s]",
	$RT::rtname,
	( eval {$QueueObj->OriginObj->CustomFieldValue('UnixName')}
	    || $QueueObj->Name ),
	$id,
    );
    my $sub  = $self->TemplateObj->MIMEObj->head->get('Subject');
    unless ( $sub =~ /\Q[$RT::rtname(?::\S+)?\s+#$tag$id\s*]\E/ ) {
        $sub =~ s/(\r\n|\n|\s)/ /gi;
        chomp $sub;
        $self->TemplateObj->MIMEObj->head->replace( 'Subject', "$tag $sub" );
    }
}

1;
