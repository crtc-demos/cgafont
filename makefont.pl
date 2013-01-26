#!/usr/bin/perl

use cgafont::patterns;
use cgafont::match;
use cgafont::viewer;

use warnings;
use strict;

my @patterns = readpatterns("patterns/patterns.txt");

## Just some test code for now:
my %test = ();

my @cchar = (
	     64+ 32+          4+  2    ,
	128+              8            ,
	128+ 64+ 32+      8            ,
	                                 0,
	128+ 64+ 32+          4+  2    ,
	     64+          8            ,
	     64+          8+  4+  2    ,
	                                 0);
$test{'c'} = \@cchar;
draw(\%test);

my %closest = ();
my @match = match(\%test, "c", \@patterns);
shift @match; # the score
my @closest = ();
foreach my $row ( @match ) { 
	push @closest, int($row / 256);
	push @closest, $row % 256;
	}
$closest{'c'} = \@closest;
draw(\%closest);


exit;
