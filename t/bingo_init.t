#!/usr/bin/perl -w

# $Id: bingo_init.t 1096 2004-01-06 20:54:01Z jonasbn $

use strict;
use Test::More tests => 2;
use lib qw(lib ../lib);
use Games::Bingo;

my @numbers;
ok(Games::Bingo::init(undef, \@numbers, 10));

is(scalar @numbers, 10);
