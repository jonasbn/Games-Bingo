#!/usr/local/bin/perl -w

# $Id: card_init.t,v 1.2 2004/01/06 20:54:01 jonasbn Exp $

use strict;
use lib qw(lib ../lib);
use Games::Bingo::Card;
use Games::Bingo::Constants qw(
	NUMBER_OF_NUMBERS_IN_CARD
	NUMBER_OF_COLUMNS_IN_CARD
);
use Test::More tests => 15;

my $verbose = 0;

my $card = Games::Bingo::Card->new();
my $fcc = $card->_init();

#test 1
isa_ok($fcc, 'Games::Bingo::ColumnCollection', 'Testing generated Collection');

#test 2
is(scalar @{$fcc}, NUMBER_OF_COLUMNS_IN_CARD, 'Number of Columns');

#test 3
my $t = NUMBER_OF_NUMBERS_IN_CARD;

for (my $i = NUMBER_OF_COLUMNS_IN_CARD-1; $i >= 0; $i--) {
	my $c = $fcc->get_column($i);
	isa_ok($c, 'Games::Bingo::Column', 'Testing column');
	$t--;
	print STDERR "\$t = $t\n" if $verbose;
	$c->get_random_number(1);
}

for (my $i = NUMBER_OF_NUMBERS_IN_CARD - NUMBER_OF_COLUMNS_IN_CARD; $i > 0; $i--) {
	my $c = $fcc->get_random_column(1);
	isa_ok($c, 'Games::Bingo::Column', 'Testing column');
	$t--;
	print STDERR "\$t = $t\n" if $verbose;
	$c->get_random_number(1);
}

is($t, 0, 'Testing the number of numbers generated');