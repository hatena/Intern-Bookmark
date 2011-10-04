package Intern::Bookmark::MoCo::Entry;
use strict;
use warnings;
use base 'Intern::Bookmark::MoCo';
use Intern::Bookmark::MoCo;
use URI;
use LWP::UserAgent;

our $NO_HTTP;

__PACKAGE__->table('entry');

__PACKAGE__->utf8_columns(qw(title));

__PACKAGE__->inflate_column(
    url => {
        inflate => sub {
            my $value = shift;
            return URI->new($value);
        },
        deflate => sub {
            my $uri = shift;
            return $uri->stringify;
        }
    },
);

sub bookmarks {
    my $self = shift;
    return moco('Bookmark')->search(
        where => { entry_id => $self->id },
        order => 'created_on DESC',
    );
}

sub update_title {
    my $self = shift;

    return if $NO_HTTP;

    my $ua = LWP::UserAgent->new(timeout => 15);
    my $res = $ua->get($self->url);
    if ($res->is_error) {
        warn sprintf '%s: %s', $self->url, $res->status_line;
        return;
    }

    my ($title) = $res->decoded_content =~ m#<title>(.+?)</title>#s;
    return unless defined $title;

    $self->title($title);
    return 1;
}

sub as_string {
    my $self = shift;

    return sprintf '[%d] %s <%s>', (
        $self->id,
        $self->title,
        $self->url,
    );
}

1;
