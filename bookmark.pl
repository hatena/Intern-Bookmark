#!/usr/bin/env perl
use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib", glob "$FindBin::Bin/modules/*/lib";
use Intern::Bookmark::MoCo;
use Pod::Usage; # for pod2usage()
use Encode::Locale;

binmode STDOUT, ':encoding(console_out)';

my %HANDLERS = (
    add    => \&add_bookmark,
    list   => \&list_bookmarks,
    delete => \&delete_bookmark,
);

my $command = shift @ARGV || 'list';

my $user = moco('User')->find(name => $ENV{USER}) || moco('User')->create(name => $ENV{USER});
my $handler = $HANDLERS{ $command } or pod2usage;

$handler->($user, @ARGV);

exit 0;

sub add_bookmark {
    my ($user, $url, $comment) = @_;

    die 'url required' unless defined $url;

    my $bookmark = $user->add_bookmark(
        url => $url,
        comment => $comment,
    );
    print 'bookmarked ', $bookmark->as_string, "\n";
}

sub list_bookmarks {
    my ($user) = @_;

    printf " *** %s's bookmarks ***\n", $user->name;

    my $bookmarks = $user->bookmarks;
    foreach my $bookmark (@$bookmarks) {
        print $bookmark->as_string, "\n";
    }
}

sub delete_bookmark {
    my ($user, $entry_id) = @_;

    die 'entry_id required' unless defined $entry_id;

    my $entry = moco('Entry')->find(id => $entry_id) or die "entry id=$entry_id not found";
    my $bookmark = $user->delete_bookmark($entry);
    if ($bookmark) {
        print 'deleted ', $bookmark->as_string, "\n";
    }
}

__END__

=head1 NAME

bookmark.pl - my bookmark

=head1 SYNOPSIS

  bookmark.pl add url [comment]

  bookmark.pl list

  bookmark.pl delete entry_id

=cut
