#!/usr/local/bin/perl -w

# $Id: divide.t,v 1.3 2003/01/30 19:39:07 jonasbn Exp $

use strict;
use lib qw(lib ../lib);
use Test::More tests => 2;
use Data::Dumper;
use Games::Bingo;
use Games::Bingo::ColumnCollection;

my $debug = 0;

my $bingo = Games::Bingo->new();

my @numbers;
$bingo->init(\@numbers, 90);

is(scalar @numbers, 90, 'Testing the initialized numbers array');

my $collection = Games::Bingo::ColumnCollection->new();
$collection->divide(9, @numbers);

is(scalar @{$collection}, 9, 'Testing the number of divided arrays');

print STDERR Dumper $collection if $debug;