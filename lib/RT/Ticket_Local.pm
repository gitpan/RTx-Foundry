use strict;
no warnings 'redefine';

sub FunctionQueueObj {
    my $self = shift;
    my $QueueObj = RT::Queue->new($self->CurrentUser);
    $QueueObj->LoadById($self->__Value('IssueStatement'));
    return $QueueObj;
}

1;
