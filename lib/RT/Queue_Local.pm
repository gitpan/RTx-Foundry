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

sub HasAdminCc {
    my ($self, $user) = @_;
    my $princ = $user->PrincipalObj;
    return $self->AdminCc->HasMember($princ);
}

sub HasCc {
    my ($self, $user) = @_;
    my $princ = $user->PrincipalObj;
    return $self->Cc->HasMember($princ);
}

sub HasWatcher {
    my ($self, $user) = @_;
    my $princ = $user->PrincipalObj;
    return $self->AdminCc->HasMember($princ)
	|| $self->Cc->HasMember($princ);
}

1;
