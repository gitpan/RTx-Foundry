no warnings 'redefine';
use strict;

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
    my $Id = $self->Name or return;
    my $Tickets = RT::Tickets->new($RT::SystemUser);
    $Tickets->LimitQueue( VALUE => 'NewUser' );
    $Tickets->LimitCustomField(
	CUSTOMFIELD => 1,
	VALUE	    => $self->Name,
    );
    return $Tickets->Last;
}

my $secret = $RT::DatabasePassword . " 300silver";

sub RecoverPasswordHash {
    my ($self, $time) = @_;
    my $id = $self->Id;
    my $name = $self->Name or return;
    my $email = $self->EmailAddress or return;

    $time ||= time;
    require Digest::SHA1;
    return "$id,$time," .Digest::SHA1::sha1_hex("$id $name $email $time $secret");
}

sub VerifyPasswordHash {
    my ($self, $token) = @_;
    my ($id, $time, $hash) = split(/,/, $token);
    return if (time - $time > 6000);
    return unless $self->Id eq $id;
    return unless "$id,$time,$hash" eq $self->RecoverPasswordHash($time);
    return 1;
}

sub _GeneratePassword {
    my $self = shift;
    my $password = shift;

    if ((caller(1))[3] eq 'RT::User::SetPassword') {
	open my $file, ">/var/spool/openfoundry/newuser." . time() . ".$$." . rand() or die $!;
	print $file $self->Name, "\n", crypt($password, int(rand(100)));
	close $file;
    }

    my $md5 = Digest::MD5->new();
    $md5->add($password);
    return ($md5->b64digest);
}

1;
