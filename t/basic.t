#!/usr/local/bin/perl -w

# $Id: basic.t,v 1.2 2003/01/03 20:16:55 jonasbn Exp $

use strict;
use lib qw(lib ../lib);
use Test::More tests => 8;

BEGIN { use_ok( 'Games::Bingo'); }
require_ok( 'Games::Bingo' );

my @taken;
my @numbers;

my $ceil = 90;

my $bingo = Games::Bingo->new();

is(ref $bingo, 'Games::Bingo', 'Testing the constructed object');

ok($bingo->take(\@taken, 1), 'Testing taking a single digit number');

is($taken[0][1], '01', 'Testing contents of 0,1');

ok($bingo->take(\@taken, 52), 'Testing taking a double digit number');

is($taken[5][2], '52', 'Testing contents of 5,2');

$bingo->init(\@numbers, $ceil);

is(scalar @numbers, $ceil, 'Testing the initialized number array');
