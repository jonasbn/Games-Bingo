#!/usr/local/bin/perl -w

# $Id: collection_get_column.t,v 1.1 2004/01/04 20:05:48 jonasbn Exp $

use strict;
use lib qw(lib ../lib);
use Games::Bingo::Card;
use Test::More tests => 11;

my $card = Games::Bingo::Card->new();
my $fcc = $card->_init();

#test 1
is(scalar @{$fcc}, 9, 'Number of Columns');

#test 2-6
my $t = 9;

for (1..9) {
	my $c = $fcc->get_column(--$t);
	isa_ok($c, 'Games::Bingo::Column', 'Testing column');
}

#test 7
is($t, 0, 'Testing the number of numbers generated');