use strict;
no warnings 'redefine';

sub LimitToEnabledQueues {
    my $self = shift;
    my $Queues = RT::Queues->new($RT::SystemUser);
    $Queues->LimitToEnabled;
    while (my $Queue = $Queues->Next) {
	$self->LimitQueue(VALUE => $Queue->Id);
    }
}

1;
