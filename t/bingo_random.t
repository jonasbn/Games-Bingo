#!/usr/bin/perl -w

# $Id: bingo_random.t,v 1.2 2004/01/06 21:01:01 jonasbn Exp $

use strict;
use Test::More tests => 1;
use lib qw(lib ../lib);
use Games::Bingo;

my $bingo = Games::Bingo->new();

like($bingo->random(90), qr/\d+/);
