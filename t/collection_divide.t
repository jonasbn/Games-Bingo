#!/usr/local/bin/perl -w

# $Id: collection_divide.t 1090 2004-01-04 20:05:48Z jonasbn $

use strict;
use Test::More tests => 2;
use lib qw(lib ../lib);
use Games::Bingo;
use Games::Bingo::ColumnCollection;

my $bingo = Games::Bingo->new();

my @numbers;
$bingo->init(\@numbers, 90);

is(scalar @numbers, 90, 'Testing the initialized numbers array');

my $collection = Games::Bingo::ColumnCollection->new();
$collection->divide(9, @numbers);

is(scalar @{$collection}, 9, 'Testing the number of divided arrays');
