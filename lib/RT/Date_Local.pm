no warnings 'redefine';

sub ISO {
    my $self = shift;
    return '1970/01/01 00:00:00' if $self->Unix == -1;
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = gmtime($self->Unix + 4 * 3600);
    $year += 1900;
    $mon++;
    return sprintf("%04d/%02d/%02d %02d:%02d:%02d", $year,$mon,$mday, $hour,$min,$sec);
}

1;
