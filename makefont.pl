#!/usr/bin/perl

use cgafont::patterns;
use cgafont::match;
use cgafont::viewer;

use warnings;
use strict;

my @patterns = readpatterns("patterns/patterns.txt");

## Just some test code for now:

my %test = ();
my @achar = (124,130,130,130,130,130,124,0); $test{'0'} = \@achar;
my @echar = (240,240,240,240,15,15,15,15); $test{'e'} = \@echar;
my @rchar = ();
for ( my $i = 0; $i < 8 ; $i++ ) { push @rchar, int(rand(256)); }
$test{'r'} = \@rchar;
draw(\%test);
print "\n";
print "diff(0) = ".join(",", match(\%test, "0", \@patterns))."\n";
print "diff(e) = ".join(",", match(\%test, "e", \@patterns))."\n";
print "diff(r) = ".join(",", match(\%test, "r", \@patterns))."\n";

exit;
