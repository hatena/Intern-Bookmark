package t::Intern::Bookmark::MoCo::Entry;
use strict;
use warnings;
use base 'Test::Class';
use Test::More;
use t::Bookmark;

sub startup : Test(startup => 1) {
    use_ok 'Intern::Bookmark::MoCo::Entry';
    t::Bookmark->truncate_db;
}

sub updated_on : Test(1) {
    my $e = Intern::Bookmark::MoCo::Entry->create;
    no warnings 'once';
    local *DateTime::now = sub {
        my $class = shift;
        return DateTime->new(year => 1970, month => 1, day => 1, @_);
    };
    $e->title('hoge');
    is $e->updated_on . '', '1970-01-01T00:00:00', 'updated_on 更新された';
}

__PACKAGE__->runtests;
