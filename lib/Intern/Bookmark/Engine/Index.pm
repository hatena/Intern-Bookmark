package Intern::Bookmark::Engine::Index;
use strict;
use warnings;
use Intern::Bookmark::Engine -Base;
use Intern::Bookmark::MoCo;

sub default : Public {
    my ($self, $r) = @_;

    if (my $user = $r->user) {
        my $page = $r->req->param('page') || 1;
        my $bookmarks = $user->bookmarks(
            page => $page
        );

        $r->stash->param(
            bookmarks => $bookmarks,
            page      => $page,
        );
    }
}

1;
