#!/usr/bin/perl -w

# $Id: card_resolve_column.t 1090 2004-01-04 20:05:48Z jonasbn $

use strict;
use Test::More tests => 90;
use lib qw(lib ../lib);
use Games::Bingo::Card;

#Testing the resolution of numbers resolv column
my $bingo = Games::Bingo->new();
my @game_numbers;
$bingo->init(\@game_numbers, 90);

my $card = Games::Bingo->new();

my $match = 0;
for(my $i = 0; $i < (scalar @game_numbers); $i++) {
	if ($game_numbers[$i] == 90) {
		#nop;
	} elsif ($game_numbers[$i] > 9) {
		$match++ if (($game_numbers[$i] % 10) == 0);
	} 
	is($card->_resolve_column($game_numbers[$i]), $match, "Testing number: $game_numbers[$i] against: $match");
}