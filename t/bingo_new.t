#!/usr/bin/perl -w

# $Id: bingo_new.t 1096 2004-01-06 20:54:01Z jonasbn $

use strict;
use Test::More tests => 3;
use lib qw(lib ../lib);
use Games::Bingo;

#test 1-2
BEGIN { use_ok( 'Games::Bingo' ); }
require_ok( 'Games::Bingo' );

#test 3
ok(my $bingo = Games::Bingo->new());
