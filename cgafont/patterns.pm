package cgafont::patterns;
our $VERSION = '1.00';
use base 'Exporter';
our @EXPORT = qw(readpatterns);
use warnings;
use strict;

# input: the filename of the patterns
# output: an array of bitmapped integers
sub readpatterns { 
	my $filename = shift;
	if ( ! ( -e $filename ) ) { return (); } 
	my @ret = ();
	open(PATTERNS, $filename);
	my $patterns = "";
	while(<PATTERNS>) { $patterns .= $_; }
	close(PATTERNS);
	my @patternsplit = split(/\n\s*\n/, $patterns);
	foreach my $pattern ( @patternsplit ) { 
		$pattern =~ s/[^.*]//g;
		$pattern =~ s/\./0/g;
		$pattern =~ s/\*/1/g;
		push @ret, unpack("N", pack("B32", substr(("0"x32).$pattern, -32)));
		}
	return @ret;
	}

1;
