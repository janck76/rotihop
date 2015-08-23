package Test::MyApp;

use strict;
use warnings;

use Readonly;
use Carp;
use Module::Metadata;
use Exporter;
use Smart::Comments;
use Data::Dumper;
use version; our $VERSION = qv('0.0.1');

our @ISA        = qw(Exporter);
our @EXPORT_OK  = qw( check_module get_config print_config );
our @EXPORT     = qw( check_module get_config print_config );

my $CONFIG;
my $MYAPP_ENV;

BEGIN {
    my $config = '/var/opt/myapp.yaml';

    Readonly $MYAPP_ENV => lc $ENV{MYAPP_ENV};
    die 'MYAPP_ENV undefiend' unless $MYAPP_ENV;
    die 'MYAPP_ENV invalid value' unless $MYAPP_ENV =~ /^prod|test$/;

    use YAML::Tiny;
    my $yaml = YAML::Tiny->read($config) or die "Can't read $config: $!";
    Readonly $CONFIG => $yaml->[0];
    die "Config undefined" unless $CONFIG;
}

sub check_module {
    my $result = shift;

    my $pkg = __PACKAGE__;
    my $dir = Module::Metadata->find_module_dir_by_name($pkg);
    my $output = "Hello from $pkg in $dir";
    if (ref $result eq 'SCALAR') {
        $$result = $output;
    }
    else {
        print "\n$output\n";
    }
    return;
}

sub print_config {
    my $common_config = $CONFIG->{common};
    my $myapp_config = $CONFIG->{$MYAPP_ENV};
    print Dumper $common_config;
    print Dumper $myapp_config;
}

sub get_config {
    return [ $CONFIG->{common}, $CONFIG->{$MYAPP_ENV} ];
}
 
