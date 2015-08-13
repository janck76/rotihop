package Test::MyApp;

use strict;
use warnings;
use Carp;
use Module::Metadata;
use Exporter;
use version; our $VERSION = qv('0.0.1');


# Module implementation here	
our @ISA        = qw(Exporter);
our @EXPORT_OK  = qw( check_module );
our @EXPORT     = qw( check_module );


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
 
1;
