#!/usr/bin/perl

use cgafont::patterns;
use cgafont::viewer;
use warnings;
use strict;

my @patterns = readpatterns("patterns/patterns.txt");

my %test = ();
my @achar = (124,130,130,130,130,130,124,0); $test{'0'} = \@achar;
draw(\%test);

# ...
