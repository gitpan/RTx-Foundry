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

1;
