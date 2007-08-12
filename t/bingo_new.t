#!/usr/bin/perl -w

# $Id: bingo_new.t 1869 2007-08-12 15:52:36Z jonasbn $

use strict;
use Test::More tests => 3;

#test 1
use_ok( 'Games::Bingo' );

my $bingo;

#test 2
ok($bingo = Games::Bingo->new(), 'calling constructor');

#test 3
isa_ok($bingo, 'Games::Bingo', 'isa test');




