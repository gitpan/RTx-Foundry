no warnings 'redefine';

%RT::SystemQueues = map { $_ => 1 } (2, 3, 4, 22);

sub LimitToGlobalOrQueue {
    my $self = shift;
    my $queue = shift;
    $self->LimitToQueue($queue);
    $self->LimitToGlobal() unless $RT::SystemQueues{$queue};

    # make sure we return global ones first
    $self->OrderBy( FIELD => 'Queue, SortOrder', ORDER => 'ASC');
}

1;
