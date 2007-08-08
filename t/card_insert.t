#!/usr/bin/perl -w

# $Id: card_insert.t 1864 2007-08-08 09:12:37Z jonasbn $

use strict;
use Test::More tests => 14;

BEGIN { use_ok( 'Games::Bingo::Card' ); }

my $card = Games::Bingo::Card->new();

#Testing the population of the card
my @numbers = qw(2 10 21 71 14 34 56 74 4 42 66 90);

my $counter;
for (my $row = 0; $row < 3; $row++) {
	for (my $number = 0; $number < 4; $number++) {
		my $n = shift(@numbers);
		$counter++;
		ok($card->_insert($row, $n));
	}
}
is($counter, 12, 'Testing our card generation');