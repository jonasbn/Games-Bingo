#!/usr/bin/perl -w

# $Id: bingo_pulled.t,v 1.2 2004/01/06 21:01:01 jonasbn Exp $

use strict;
use Test::More tests => 2;
use lib qw(lib ../lib);
use Games::Bingo;

my $bingo = Games::Bingo->new();

my $number = 12;
$bingo->pull($number);

my @pulled = $bingo->_all_pulled();

is($bingo->pulled($number), 1, 'Testing pulled, success');

is($bingo->pulled(91), 0, 'Testing pulled, failing with 91');