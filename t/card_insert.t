#!/usr/bin/perl -w

# $Id: card_insert.t,v 1.2 2004/01/06 20:54:01 jonasbn Exp $

use strict;
use Test::More tests => 13;
use lib qw(lib ../lib);
use Games::Bingo::Card;

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