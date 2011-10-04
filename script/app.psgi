# vim:set ft=perl:
use strict;
use warnings;
use lib glob 'modules/*/lib';
use lib 'lib';


use UNIVERSAL::require;
use Path::Class;
use Plack::Builder;
use LWP::Simple qw($ua);

my $namespace = 'Intern::Bookmark';
$namespace->use or die $@;

my $root = file(__FILE__)->parent->parent;

$ENV{GATEWAY_INTERFACE} = 1; ### disable plack's accesslog
$ENV{PLACK_ENV} = ($ENV{RIDGE_ENV} =~ /production|staging/) ? 'production' : 'development';

builder {
    unless ($ENV{PLACK_ENV} eq 'production') {
        enable "Plack::Middleware::Debug";
        enable "Plack::Middleware::Static",
            path => qr{^/(images/|js/|css/|favicon\.ico)},
            root => $root->subdir('static');
    }

    enable "Plack::Middleware::ReverseProxy";

    enable 'Plack::Middleware::Session::Cookie';

    enable 'Plack::Middleware::HatenaOAuth',
        consumer_key       => 'vUarxVrr0NHiTg==',
        consumer_secret    => 'RqbbFaPN2ubYqL/+0F5gKUe7dHc=',
        login_path         => '/login',
        ua                 => $ua;

    sub {
        my $env = shift;
        $namespace->process($env, {
            root => $root,
        });
    }
};

