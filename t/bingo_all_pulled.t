#!/usr/bin/perl -w

# $Id: bingo_all_pulled.t 1092 2004-01-06 20:13:32Z jonasbn $

use strict;
use Test::More tests => 2;
use lib qw(lib ../lib);
use Games::Bingo;

my $bingo = Games::Bingo->new();

#test 1
my @pulled = $bingo->_all_pulled();
is(scalar @pulled, 0, 'Testing _all_pulled'); 

#test 2
my $number = $bingo->play();
$bingo->pull($number);

@pulled = $bingo->_all_pulled();
is(scalar @pulled, 1, 'Testing _all_pulled');
