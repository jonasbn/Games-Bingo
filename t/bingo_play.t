#!/usr/bin/perl -w

# $Id: bingo_play.t 1864 2007-08-08 09:12:37Z jonasbn $

use strict;
use Test::More tests => 11;

#test 1
BEGIN { use_ok( 'Games::Bingo' ); }

my $bingo = Games::Bingo->new(10);

for (my $i = 10; $i > 0; $i--) {
	ok($bingo->play());
}
