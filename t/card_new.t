#!/usr/bin/perl -w

use strict;
use Test::More tests => 44;
use lib qw(lib ../lib);
use Games::Bingo::Card;

my $amount = 10;

#test 1-2
BEGIN { use_ok( 'Games::Bingo::Card' ); }
require_ok( 'Games::Bingo::Card' );

#test 3
my $bingo = Games::Bingo->new($amount);
is(scalar @{$bingo->{'_numbers'}}, $amount, 'Testing the initialized numbers array');

#test 37-43
my $pulled;
while ($amount) {
	my $number = $bingo->play();
	ok($number <= 10, 'testing the number');
	ok($number > 0, 'testing the number');
	--$amount;
	is(scalar @{$bingo->{'_numbers'}}, $amount, 'Testing the remaining numbers');
	++$pulled;
	is(scalar ($bingo->_all_pulled), $pulled, 'Testing the pulled numbers');
}

#test 44
my $card = Games::Bingo::Card->new();
is(ref $card, 'Games::Bingo::Card', 'Testing the object');