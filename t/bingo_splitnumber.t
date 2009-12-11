#!/usr/bin/perl -w

# $Id: card_splitnumber.t 1640 2006-12-17 10:40:02Z jonasbn $

use strict;
use Test::More tests => 9;

BEGIN { use_ok( 'Games::Bingo' ); }

my $card = Games::Bingo->new();

my ($x, $y, $modified);
ok(($x, $y, $modified) = $card->splitnumber(12));

is($x, 1);
is($y, 2);
is($modified, 12);

ok(($x, $y, $modified) = $card->splitnumber(1));

is($x, 0);
is($y, 1);
is($modified, "01");
