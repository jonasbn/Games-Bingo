#!/usr/bin/perl -w

# $Id: bingo_pull.t 1092 2004-01-06 20:13:32Z jonasbn $

use strict;
use Test::More tests => 2;
use lib qw(lib ../lib);
use Games::Bingo;

my $bingo = Games::Bingo->new();

my $number = $bingo->play();
ok($bingo->pull($number));

my @pulled = $bingo->_all_pulled();
is(scalar @pulled, 1); 