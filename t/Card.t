#!/usr/local/bin/perl -w

# $Id: Card.t,v 1.3 2003/07/30 18:50:01 jonasbn Exp $

use strict;
use lib qw(lib ../lib);
use Test::More tests => 46;
use Data::Dumper;

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
my $b = Games::Bingo->new(90);
my $card = Games::Bingo::Card->new($b);
is(ref $card, 'Games::Bingo::Card', 'Testing the object');


#test 45
my $bingo2 = Games::Bingo->new(90);
is($card->validate($bingo2), 0, 'Testing validate');

#test 46
for(1 .. 90) {
	$bingo2->play();
}

is($card->validate($bingo2), 1, 'Testing validate');

#print STDERR Dumper $bingo2;