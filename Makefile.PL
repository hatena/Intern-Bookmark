use inc::Module::Install;

name 'Intern-Bookmark';
version '0.01';
license 'perl';

requires 'URI';
requires 'LWP::UserAgent';
requires 'DateTime';
requires 'DateTime::Format::MySQL';
requires 'FindBin';
requires 'Pod::Usage';
requires 'Getopt::Long';

tests 't/*.t';

test_requires 'Test::More';
test_requires 'Test::Class';

auto_include;

WriteAll;
