package t::Bookmark;
use strict;
use warnings;
use lib 'lib', glob 'modules/*/lib';
use Intern::Bookmark::DataBase;

Intern::Bookmark::DataBase->dsn('dbi:mysql:dbname=intern_bookmark_test');

$Intern::Bookmark::MoCo::Entry::NO_HTTP = 1;

sub truncate_db {
    Intern::Bookmark::DataBase->execute("TRUNCATE TABLE $_") for qw(user entry bookmark);
}

1;
