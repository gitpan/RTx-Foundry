
sub CustomFieldValue {
    my ($self, $id) = @_;
    eval { $self->CustomFieldValues($id)->First->Content };
}

sub SetCustomFieldValue {
    my ($self, $id, $value) = @_;
    eval { $self->CustomFieldValues($id)->First->SetContent($value) };
}

1;
