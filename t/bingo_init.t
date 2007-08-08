#!/usr/bin/perl -w

# $Id: bingo_init.t 1864 2007-08-08 09:12:37Z jonasbn $

use strict;
use Test::More tests => 3;

#test 1
BEGIN { use_ok( 'Games::Bingo' ); }

my $bingo = Games::Bingo->new();

#test 2
my @numbers;
ok($bingo->init(\@numbers, 10));

#test 3
is(scalar @numbers, 10);
