#!/usr/bin/perl -w

# $Id: bingo_play.t 1092 2004-01-06 20:13:32Z jonasbn $

use strict;
use Test::More tests => 10;
use lib qw(lib ../lib);
use Games::Bingo;

my $bingo = Games::Bingo->new(10);

for (my $i = 10; $i > 0; $i--) {
	ok($bingo->play());
}