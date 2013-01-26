package cgafont::viewer;
our $VERSION = '1.00';
use base 'Exporter';
our @EXPORT = qw(draw);
use warnings;
use strict;

# input: a font (a hash, each key of which is a character, corresponding to a value, which is an array of bitmapped integers for each line of the character)
sub draw { 
	if ( $#_ == -1 ) { return; } 
	my %font = %{$_[0]};
	foreach my $key ( sort keys %font ) { 
		print "$key\n";
		foreach my $line ( @{$font{$key}} ) { 
			my $bits = substr(unpack("B32", pack("N", $line)), -8);
			$bits =~ tr/01/.O/;
			print "\t$bits\n";
			}
		}
	}

1;
