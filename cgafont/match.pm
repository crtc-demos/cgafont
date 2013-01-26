package cgafont::match;
our $VERSION = '1.00';
use base 'Exporter';
our @EXPORT = qw(match);
use warnings;
use strict;

# input: a character (a set of bitmapped integers)
# output: an array.
#   element 0 = the number of pixels that the character differs from the pattern found.
#   remaining elements = the best pattern found for each pair of rows.

sub match { 
	my %font = %{$_[0]};	 # array of 8-bit integers.
	my $character = $_[1];
	my @patterns = @{$_[2]}; # 16 bit

	my @rows = @{$font{$character}};
	my $totaldifference = 0;
	my @ret = ();

	# Take in pairs
	for ( my $i = 0; $i < 8; $i += 2 ) { 
		# Construct bitmap
		my $bothrows = $rows[$i] * 256 + $rows[$i+1];

		# Find the closest match
		my $minimum = -1;
		my $minimumat = -1;

		for ( my $patternnumber = 0; $patternnumber <= $#patterns; $patternnumber++ ) { 
			my $pattern = $patterns[$patternnumber];
			my $xor = $pattern ^ $bothrows;
			my $binary = unpack("B32", pack("N", $xor));
			$binary =~ s/0//g;
			my $difference = length($binary);
			if ( $minimum == -1 || $difference < $minimum ) { 
				$minimum = $difference;
				$minimumat = $pattern;
				}
			}

		if ( $minimum >= 0 ) { $totaldifference += $minimum; } 
		push @ret, $minimumat;
		}
	
	unshift @ret, $totaldifference;
	return @ret;
	}

1;
