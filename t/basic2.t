#!/usr/local/bin/perl -w

# $Id: basic2.t,v 1.1 2003/07/27 20:45:07 jonasbn Exp $

use strict;
use Test::More tests => 6;
use lib qw(lib ../lib);
use Games::Bingo;

my $ceil = 90;

my $bingo = Games::Bingo->new($ceil);

#test 1
is(ref $bingo, 'Games::Bingo', 'Testing the constructed object');

#test 2
ok($bingo->pull(1), 'Testing taking a single digit number');

#test 3
is($bingo->{_pulled}[0][1], '01', 'Testing contents of 0,1');

#test 4
ok($bingo->pull(52), 'Testing taking a double digit number');

#test 5
is($bingo->{_pulled}[5][2], '52', 'Testing contents of 5,2');

#test 6
is(scalar $bingo->_all_pulled, 2, 'Checking that we have pulled 2 numbers');
