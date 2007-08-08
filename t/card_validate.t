#!/usr/bin/perl -w

# $Id: card_validate.t 1864 2007-08-08 09:12:37Z jonasbn $

use strict;
use Test::More tests => 3;

BEGIN { use_ok( 'Games::Bingo::Card' ); }

my $card = Games::Bingo::Card->new();
$card->populate();

#test 1
my $bingo = Games::Bingo->new(90);
is($card->validate($bingo), 0, 'Testing validate');

#test 2
for(1 .. 90) {
	$bingo->play();
}
is($card->validate($bingo), 1, 'Testing validate');