#!/usr/bin/perl -w

# $Id: card_splitnumber.t 1096 2004-01-06 20:54:01Z jonasbn $

use strict;
use Test::More tests => 8;
use lib qw(lib ../lib);
use Games::Bingo::Card;

my $card = Games::Bingo::Card->new();

my ($x, $y, $modified);
ok(($x, $y, $modified) = $card->splitnumber(12));

is($x, 1);
is($y, 2);
is($modified, 12);

ok(($x, $y, $modified) = $card->splitnumber(1));

is($x, 0);
is($y, 1);
is($modified, "01");
