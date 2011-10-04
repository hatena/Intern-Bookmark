package Intern::Bookmark::DataBase;
use strict;
use warnings;
use base 'DBIx::MoCo::DataBase';

__PACKAGE__->dsn('dbi:mysql:dbname=intern_bookmark');

__PACKAGE__->username('root');
__PACKAGE__->password('');

1;
