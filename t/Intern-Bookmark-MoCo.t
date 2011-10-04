package t::Intern::Bookmark::MoCo;
use strict;
use warnings;
use base 'Test::Class';
use Test::More;
use t::Bookmark;

sub startup : Test(startup => 1) {
    use_ok 'Intern::Bookmark::MoCo';
}

__PACKAGE__->runtests;
