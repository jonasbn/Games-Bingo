#!/usr/bin/perl -w

# $Id: collection_remove_column.t,v 1.2 2004/01/06 20:54:01 jonasbn Exp $

use strict;
use Test::More tests => 2;
use lib qw(lib ../lib);
use Games::Bingo::ColumnCollection;

my $c1 = Games::Bingo::Column->new(0, 1, 2, 3, 4, 5, 6, 7, 8, 9);
my $c2 = Games::Bingo::Column->new(1, 11, 12, 13, 14, 15, 16, 17, 18, 19);
my $c3 = Games::Bingo::Column->new(2, 21, 22, 23, 24, 25, 26, 27, 28, 29);

my $col = Games::Bingo::ColumnCollection->new($c1, $c2, $c3);

is(scalar @{$col}, 3);

$col->_remove_column(1);

is(scalar @{$col}, 2);
