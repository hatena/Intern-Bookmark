package Intern::Bookmark;
use strict;
use warnings;
use base qw/Ridge/;
use Intern::Bookmark::MoCo;

__PACKAGE__->configure;

sub user {
    my ($self) = @_;
    if (my $name = $self->req->env->{'hatena.user'}) {
        my $user = moco('User')->find(name => $name) || moco('User')->create(name => $name);
    } else {
        '';
    }
}

1;
