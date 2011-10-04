package Intern::Bookmark::Engine::Bookmark;
use strict;
use warnings;
use Intern::Bookmark::Engine -Base;
use Intern::Bookmark::MoCo;

sub default : Public {
    my ($self, $r) = @_;
    my $id = $r->req->param('id');
    my $entry = moco("Entry")->find(id => $id);
    my $bookmarks = $entry->bookmarks;

    $r->stash->param(
        entry    => $entry,
        bookmarks => $bookmarks,
    );
}

sub add : Public {
    my ($self, $r) = @_;

    my $id = $r->req->param('id');
    my $entry = $id ? moco("Entry")->find(id => $id) : undef;
    my $bookmark = $entry ? $r->user->bookmark_on_entry($entry) : undef;

    $r->stash->param(
        entry => $entry,
        bookmark => $bookmark,
    );

    $r->follow_method;
}

sub _add_get {
}

sub _add_post {
    my ($self, $r) = @_;
    my $url = $r->req->param('url');
    my $comment = $r->req->param('comment');

    my $bookmark = $r->user->add_bookmark(
        url => $url,
        comment => $comment,
    );

    $r->res->redirect('/');
}

sub delete : Public {
    my ($self, $r) = @_;

    my $id = $r->req->param('id');
    my $entry = $id ? moco("Entry")->find(id => $id) : undef;
    my $bookmark = $entry ? $r->user->bookmark_on_entry($entry) : undef;

    $r->stash->param(
        entry => $entry,
        bookmark => $bookmark,
    );

    $r->follow_method;
}

sub _delete_get {
}

sub _delete_post {
    my ($self, $r) = @_;

    $r->user->delete_bookmark($r->stash->param('entry'));

    $r->res->redirect('/');
}

1;
