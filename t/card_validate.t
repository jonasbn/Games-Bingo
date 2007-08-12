#!/usr/bin/perl -w

# $Id: card_validate.t 1869 2007-08-12 15:52:36Z jonasbn $

use strict;
use Test::More tests => 4;

use_ok( 'Games::Bingo::Card' );

my $card;

$card = Games::Bingo::Card->new();
$card->populate();

#test 1
my $bingo = Games::Bingo->new(90);
is($card->validate($bingo), 0, 'Testing validate');

#test 2
for(1 .. 90) {
	$bingo->play();
}
is($card->validate($bingo), 1, 'Testing validate');

$card = Games::Bingo::Card->new();
$card->populate();

is($card->validate($bingo), 0, 'Testing validate');
