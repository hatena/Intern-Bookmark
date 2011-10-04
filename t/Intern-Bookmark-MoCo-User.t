package t::Intern::Bookmark::MoCo::User;
use strict;
use warnings;
use base 'Test::Class';
use Test::More;
use t::Bookmark;

sub startup : Test(startup => 1) {
    use_ok 'Intern::Bookmark::MoCo::User';
    t::Bookmark->truncate_db;
}

sub add_bookmark : Test(5) {
    ok my $user = Intern::Bookmark::MoCo::User->create(name => 'test_user_1'), 'create user';
    is_deeply $user->bookmarks->to_a, [];

    my $bookmark = $user->add_bookmark(url => 'http://www.example.com/', comment => 'nice page');

    isa_ok $bookmark, 'Intern::Bookmark::MoCo::Bookmark';
    is $bookmark->entry->url, 'http://www.example.com/', '$bookmark url';

    is_deeply
        $user->bookmarks->map(sub { $_->entry->url })->to_a,
        [ 'http://www.example.com/' ],
        '$user->bookmarks';
}

__PACKAGE__->runtests;
