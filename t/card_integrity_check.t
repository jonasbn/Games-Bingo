#!/usr/local/bin/perl -w

# $Id: card_integrity_check.t 1864 2007-08-08 09:12:37Z jonasbn $

use strict;
use Test::More tests => 3;

BEGIN { use_ok( 'Games::Bingo::Card' ); }

use Games::Bingo::Constants qw(
	NUMBER_OF_ROWS_IN_CARD
	NUMBER_OF_COLUMNS_IN_CARD
	NUMBER_OF_NUMBERS_IN_ROW
);

#test 1
{
	my @numbers = qw(1 19 25 69 88 37 47 63 73 87 14 30 41 56 72);

	my $c = Games::Bingo::Card->new();

	for (my $row = 0; $row < NUMBER_OF_ROWS_IN_CARD; $row++) {
	
		for (my $number = 0; $number < NUMBER_OF_NUMBERS_IN_ROW; $number++) {
			my $n = shift(@numbers);
			$c->_insert($row, $n);
		}
	}
	is($c->_integrity_check(), 1, 'Testing our card integrity');
}

#test 2
{
	my @numbers = qw(19 19 25 69 88 37 47 63 73 87 14 30 41 56 72);
	
	my $c = Games::Bingo::Card->new();

	for (my $row = 0; $row < NUMBER_OF_ROWS_IN_CARD; $row++) {
	
		for (my $number = 0; $number < NUMBER_OF_NUMBERS_IN_ROW; $number++) {
			my $n = shift(@numbers);
			$c->_insert($row, $n);
		}
	}
	is($c->_integrity_check(), 0, 'Testing our card integrity');
}
