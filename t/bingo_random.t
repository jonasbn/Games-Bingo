#!/usr/bin/perl -w

# $Id: bingo_random.t 1864 2007-08-08 09:12:37Z jonasbn $

use strict;
use Test::More tests => 2;

#test 1
BEGIN { use_ok( 'Games::Bingo' ); }

my $bingo = Games::Bingo->new();

like($bingo->random(90), qr/\d+/);
