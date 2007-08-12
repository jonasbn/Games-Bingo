#!/usr/bin/perl -w

# $Id: bingo_all_pulled.t 1869 2007-08-12 15:52:36Z jonasbn $

use strict;
use Test::More tests => 4;

#test 1
use_ok( 'Games::Bingo' );

my $bingo = Games::Bingo->new();

my @pulled = $bingo->_all_pulled();

#test 1
is(scalar @pulled, 0, 'asserting _all_pulled to 0'); 

#test 2
my $number = $bingo->play();
$bingo->pull($number);

ok(@pulled = $bingo->_all_pulled(), 'calling _all_pulled');

#test 3
is(scalar @pulled, 1, 'asserting _all_pulled to 1');
