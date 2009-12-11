#!/usr/bin/perl -w

# $Id: bingo_pull.t 1869 2007-08-12 15:52:36Z jonasbn $

use strict;
use Test::More tests => 3;

#test 1
use_ok( 'Games::Bingo' );

my $bingo = Games::Bingo->new();

my $number = $bingo->play();
ok($bingo->pull($number));

my @pulled = $bingo->_all_pulled();
is(scalar @pulled, 1); 