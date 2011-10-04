package Intern::Bookmark::MoCo::User;
use strict;
use warnings;
use base 'Intern::Bookmark::MoCo';
use Intern::Bookmark::MoCo;
use Carp qw(croak);

__PACKAGE__->table('user');

sub bookmarks {
    my $self = shift;
    my %opts = @_;
    my $page = $opts{page} || 1;
    my $limit = $opts{limit} || 3;
    my $offset = ($page - 1) * $limit;

    return moco('Bookmark')->search(
        where  => { user_id => $self->id },
        limit  => $limit,
        offset => $offset,
        order  => 'created_on DESC',
    );
}

sub bookmark_on_entry {
    my ($self, $entry) = @_;
    return moco('Bookmark')->find(
        user_id => $self->id,
        entry_id => $entry->id,
    );
}

sub add_bookmark {
    my ($self, %args) = @_;

    my $url = $args{url} or croak q(add_bookmark: parameter 'url' required);

    my $entry = moco('Entry')->find(url => $url);
    if (not $entry) {
        $entry = moco('Entry')->create(url => $url);
        $entry->update_title;
    }

    if (my $bookmark = $self->bookmark_on_entry($entry)) {
        $bookmark->comment($args{comment});
        return $bookmark;
    } else {
        return moco('Bookmark')->create(
            user_id => $self->id,
            entry_id => $entry->id,
            comment => $args{comment},
        );
    }
}

sub delete_bookmark {
    my ($self, $entry) = @_;
    my $bookmark = $self->bookmark_on_entry($entry) or return;
    $bookmark->delete;
    return $bookmark;
}

1;
