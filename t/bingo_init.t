#!/usr/bin/perl -w

# $Id: bingo_init.t 1869 2007-08-12 15:52:36Z jonasbn $

use strict;
use Test::More tests => 3;

#test 1
use_ok( 'Games::Bingo' );

my $bingo = Games::Bingo->new();

#test 2
my @numbers;
ok($bingo->init(\@numbers, 10));

#test 3
is(scalar @numbers, 10);
