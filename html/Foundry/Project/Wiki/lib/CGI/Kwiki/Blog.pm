package CGI::Kwiki::Blog;
$VERSION = '0.18';
use strict;
use base 'CGI::Kwiki';

use constant BLOG_ENTRIES => 7;

sub run_cgi {
    eval "use CGI::Carp qw(fatalsToBrowser)";
    die $@ if $@;
    my $driver = CGI::Kwiki::load_driver();

    my $cgi_class = (eval { require CGI::Fast; 1 } ? 'CGI::Fast' : 'CGI');
    while (my $cgi = $cgi_class->new) {
        my $self = __PACKAGE__->new($driver);
        my $html = $self->process;
        if (ref $html) {
            print CGI::redirect($html->{redirect});
        } else {
            print $driver->cookie->header, $html;
        }
	last if $cgi_class eq 'CGI';
    }
}

sub handler {
    my ($r) = @_;
    my $base_directory = $_[1] || $r->location;
    chdir($base_directory) 
      or die "Can't chdir to '$base_directory'\n";

    my $driver = CGI::Kwiki::load_driver();
    $CGI::Kwiki::user_name = 
      $ENV{REMOTE_USER} ||
      $r->get_remote_host || 
      $r->connection->remote_ip;
    my $self = __PACKAGE__->new($driver);
    my $html = $self->process;
    if (ref $html) {
        $r->method('GET');
        $r->headers_in->unset('Content-length');
        $r->headers_out->{'Location'} = $html->{redirect};
        $r->status(302);
        $r->send_http_header if $r->can('send_http_header');
    }
    else {
        $r->print($driver->cookie->header, $html);
        $r->status(200);
    }
    return;
}

sub process {
    my ($self) = @_;
    local $0 = ($CGI::Kwiki::index || 'index.cgi');
    my $script = ($CGI::Kwiki::script || 'blog.cgi');
    my $blog_id = '';
    my @blog_pages = sort {$b cmp $a} 
        map {s/.*[\\\/]//; $_} 
        glob "metabase/blog/*";
    if (@blog_pages) {
        $blog_id = $self->cgi->blog_id
          or return {redirect => "$script?$blog_pages[0]"};
    }
    my $i;
    for ($i = 0; $i < @blog_pages; $i++) {
        last if $blog_id >= $blog_pages[$i];
    }
    my @blog_ids = splice(@blog_pages, $i, BLOG_ENTRIES);
    my $output = $self->template->process('blog_header');
    for my $blog_id (@blog_ids) {
        my ($page_id, $date) = 
          $self->get_blog_info($blog_id);
        my $wiki_text = $self->database->load($page_id);
        my $formatted = $self->formatter->process($wiki_text);
        $output .= $self->template->process('blog_entry',
            entry_text => $formatted,
            blog_date => $date,
            page_id => $page_id,
            blog_id => $blog_id,
        );
    }
    $output .= $self->template->process('blog_footer');
}

sub get_blog_info {
    my ($self, $blog_id) = @_;
    my $blog_path = "metabase/blog/$blog_id";
    open BLOG, $blog_path
      or die "Can't open $blog_path for input:\n$!";
    binmode(BLOG, ':utf8') if $self->use_utf8;
    my $blog_text = do {local $/; <BLOG>};
    close BLOG;
    my $page_id = ($blog_text =~ /^page_id:\s+(.*)/m) ? $1 : '';
    my $date = ($blog_text =~ /^date:\s+(.*)/m) ? $1 : '';
    return ($page_id, $date);
}

sub create_entry {
    my ($self) = @_;
    my ($sec, $min, $hour, $mday, $mon, $year) = gmtime;
    $year += 1900;
    $mon++;
    my $blog_id = sprintf "%4d%02d%02d%02d%02d%02d",
      $year, $mon, $mday, $hour, $min, $sec;
    my $blog_path = "metabase/blog/$blog_id";
    my $page_id = $self->cgi->page_id;
    my $date = gmtime;
    open BLOG, "> $blog_path"
      or die "Can't open $blog_path for output:\n$!";
    binmode(BLOG, ':utf8') if $self->use_utf8;
    print BLOG <<END;
page_id: $page_id
date: $date
END
    close BLOG;    
}

1;

__END__

=head1 NAME 

CGI::Kwiki::Blog - Blogging Class for CGI::Kwiki

=head1 DESCRIPTION

See installed kwiki pages for more information.

=head1 AUTHOR

Brian Ingerson <INGY@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2003. Brian Ingerson. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut
