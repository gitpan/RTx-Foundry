no warnings 'redefine';

@ACTIVE_STATUS = qw(new open stalled reopened);
@INACTIVE_STATUS = qw(resolved rejected deleted);
@STATUS = (@ACTIVE_STATUS, @INACTIVE_STATUS);

sub SetOrigin {
    my $self = shift;
    $self->SetDefaultDueIn(@_);
}

sub Origin {
    my $self = shift;
    $self->DefaultDueIn;
}

sub OriginObj {
    my $self = shift;
    my $Id = $self->DefaultDueIn or return;
    my $Ticket = RT::Ticket->new($RT::SystemUser);
    $Ticket->Load($Id);
    return unless $Ticket->Id;
    $Ticket;
}

sub CustomFields {
    my $self = shift;

    my $cfs = RT::CustomFields->new( $self->CurrentUser );
    if ( $self->CurrentUserHasRight('SeeQueue') ) {
	if ($self->Disabled and $self->Description eq 'Open Foundry System') {
	    $cfs->LimitToQueue( $self->Id );
	}
	else {
	    $cfs->LimitToGlobalOrQueue( $self->Id );
	}
    }
    return ($cfs);
}

sub LoadByUnixName {
    my ($self, $UnixName) = @_;
    my $Queues = RT::Queues->new($self->CurrentUser);
    $Queues->RowsPerPage(1);
    $Queues->Columns('id', 'DefaultDueIn');
    my $tcfv = $Queues->Join(
	TYPE   => 'left',
	ALIAS1 => 'main',
	FIELD1 => 'DefaultDueIn',
	TABLE2 => 'TicketCustomFieldValues',
	FIELD2 => 'Ticket'
    );
    my $cf = $Queues->Join(
	TYPE   => 'left',
	ALIAS1 => $tcfv,
	FIELD1 => 'CustomField',
	TABLE2 => 'CustomFields',
	FIELD2 => 'id'
    );
    $Queues->Limit(
	ALIAS => $tcfv,
	FIELD => 'Content',
	VALUE => $UnixName,
    );
    $Queues->Limit(
	ALIAS => $cf,
	FIELD => 'Name',
	VALUE => 'UnixName',
    );
    $Queues->LimitToEnabled;
    $Queues->OrderBy( FIELD => 'id' );

    my $Queue = $Queues->First;
    return $self->LoadById($Queue ? $Queue->id : 0);
}

use constant FunctionsMap => (
    [ Basics        => 'Basics'           # loc
  ],[ Members       => 'Members'          # loc
  ],[ News          => 'News'             # loc
  ],[ Upload        => 'Release Plans'    # loc
  ],[ Forum         => 'Forums'           # loc
  ],[ CustomField   => 'Tracker Fields'   # loc
  ],[ Jobs          => 'Help Wanted'      # loc
  ],[ Citations     => 'Citations'        # loc
  ],[ References    => 'References'       # loc
  ],
);

sub FunctionsACL {
    my ($self, $role) = @_;
    return (map $_->[0], +FunctionsMap) if $role eq 'admin';
    return split(/\s+/, $self->Attribute("ACL-$role"));
}

sub FunctionItems {
    my ($self, $function) = @_;
    my $Items = RT::Tickets->new($self->CurrentUser);
    $Items->LimitQueue( VALUE => "Project$function" );
    $Items->Limit(
        FIELD => 'IssueStatement',
        VALUE => $self->Id
    ) if $self->Id;
    $Items->OrderBy( FIELD => 'Id', ORDER => 'DESC' );

    # XXX - for jobs, limit its lifetime visibility - XXX

    return $Items;
}

sub CreateFunctionItem {
    my ($self, $function, $args) = @_;

    my ($Item, @rv) = HTML::Mason::Commands::CreateTicket(
        %$args, Queue => "Project$function",
    );
    $Item->Id or die @rv;
    $Item->__Set( Field => 'IssueStatement', Value => $self->Id );

    return $Item;
}

sub LoadFunctionItem {
    my ($self, $function, $id) = @_;

    my $Item = RT::Ticket->new($self->CurrentUser);
    $Item->Load($id) or return;
    $Item->QueueObj->Name == "Project$function" or return;
    $Item->__Value('IssueStatement') == $self->Id or return;
    return $Item;
}

my %DefaultDownloadACL = (
    role => '0-anybody',
    collect => 0,
);

sub DownloadACL {
    my ($self, $function) = @_;
    my $rv = $self->Attribute("Download-$function");
    return ( defined($rv) ? $rv : $DefaultDownloadACL{$function} );
}

sub SetDownloadACL {
    my ($self, $function, $value) = @_;
    $value = $DefaultDownloadACL{$function} unless defined $value;
    $self->SetAttribute("Download-$function", $value);
}

1;
