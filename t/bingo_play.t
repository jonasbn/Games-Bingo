#!/usr/bin/perl -w

# $Id: bingo_play.t,v 1.1 2004/01/06 20:13:32 jonasbn Exp $

use strict;
use Test::More tests => 10;
use lib qw(lib ../lib);
use Games::Bingo;

my $bingo = Games::Bingo->new(10);

for (my $i = 10; $i > 0; $i--) {
	ok($bingo->play());
}