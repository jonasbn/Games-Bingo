#!/usr/bin/perl -w

# $Id: bingo_random.t 1869 2007-08-12 15:52:36Z jonasbn $

use strict;
use Test::More tests => 2;

#test 1
use_ok( 'Games::Bingo' );

my $bingo = Games::Bingo->new();

like($bingo->random(90), qr/\d+/);
