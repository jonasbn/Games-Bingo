#!/usr/bin/perl -w

# $Id: card_validate.t,v 1.2 2004/01/06 20:54:01 jonasbn Exp $

use strict;
use Test::More tests => 2;
use lib qw(lib ../lib);
use Games::Bingo::Card;

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