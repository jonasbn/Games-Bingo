#!/usr/bin/perl -w

# $Id: bingo_pulled.t 1869 2007-08-12 15:52:36Z jonasbn $

use strict;
use Test::More tests => 3;

#test 1
use_ok( 'Games::Bingo' );

my $bingo = Games::Bingo->new();

my $number = 12;
$bingo->pull($number);

my @pulled = $bingo->_all_pulled();

is($bingo->pulled($number), 1, 'Testing pulled, success');

is($bingo->pulled(91), 0, 'Testing pulled, failing with 91');