# $Id: short.t,v 1.2 2003/12/27 10:27:16 jonasbn Exp $

use strict;
use Test::More tests => 100;
use lib qw(lib ../lib);
use Games::Bingo::Card;
use Games::Bingo::Constants qw(NUMBER_OF_NUMBERS_IN_CARD);

for (1..100) {
	my $card = Games::Bingo::Card->new();
	$card->populate();
	my $number = 0;
	foreach my $column (@{$card}) {
		foreach my $row (@{$column}) {
			if ($row =~ m/^\d+$/c) {
				$number++;
			}
		}
	}
	is($number, NUMBER_OF_NUMBERS_IN_CARD);
}