#!/usr/bin/perl -w

# $Id: bingo_take.t 1864 2007-08-08 09:12:37Z jonasbn $

use strict;
use Test::More tests => 3;

#test 1
BEGIN { use_ok( 'Games::Bingo' ); }

my $bingo = Games::Bingo->new();
my @taken;

my $number = $bingo->play();
ok($bingo->take(\@taken, $number));

my @pulled = $bingo->_all_pulled();
is(scalar @pulled, 1); 