# $Id: sort.t,v 1.2 2003/12/27 10:27:16 jonasbn Exp $

use strict;
use Test::More tests => qw(no_plan);
use lib qw(lib ../lib);
use Games::Bingo::Card;
use Games::Bingo::Constants qw(NUMBER_OF_NUMBERS_IN_CARD);

ok(1);

for (1..100) {
	my $card = Games::Bingo::Card->new();
	$card->populate();
	my $number = 0;
	foreach my $column (@{$card}) {
		my $tmp;
		foreach my $row (@{$column}) {
			if ($row =~ m/^\d+$/c) {
				if ($tmp) {
					my $test = 1;
					print STDERR "\t$row < $tmp\n";
					$test = ($row > $tmp);
					ok($test);
				}
				$tmp = $row;
			}
		}
	}
}