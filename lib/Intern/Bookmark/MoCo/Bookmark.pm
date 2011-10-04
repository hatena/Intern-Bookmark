package Intern::Bookmark::MoCo::Bookmark;
use strict;
use warnings;
use base 'Intern::Bookmark::MoCo';
use Intern::Bookmark::MoCo;

__PACKAGE__->table('bookmark');

__PACKAGE__->utf8_columns(qw(comment));

sub entry {
    my $self = shift;
    return moco('Entry')->find(
        id => $self->entry_id
    );
}

sub user {
    my $self = shift;
    return moco('User')->find(
        id => $self->user_id
    );
}

sub as_string {
    my $self = shift;

    return sprintf "%s\n  @%s %s", (
        $self->entry->as_string,
        $self->created_on->ymd,
        $self->comment,
    );
}

1;
