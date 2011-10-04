#!perl
use strict;
use warnings;
use Test::More qw/no_plan/;
use HTTP::Status;
use Ridge::Test 'Intern::Bookmark';

is get('/index')->code, RC_OK;

1;
