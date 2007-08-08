#!/usr/bin/perl -w

# $Id: bingo_new.t 1864 2007-08-08 09:12:37Z jonasbn $

use strict;
use Test::More tests => 3;

#test 1
BEGIN { use_ok( 'Games::Bingo' ); }

#test 2
ok(my $bingo = Games::Bingo->new(), 'calling constructor');

#test 3
isa_ok($bingo, 'Games::Bingo', 'isa test');
