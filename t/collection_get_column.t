#!/usr/local/bin/perl -w

# $Id: collection_get_column.t 1864 2007-08-08 09:12:37Z jonasbn $

use strict;
use Test::More tests => 12;

BEGIN { use_ok( 'Games::Bingo::Card' ); }

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