#!/usr/local/bin/perl -w

use strict;
use Data::Dumper;
use Test::More tests => 2;
use lib qw(lib ../lib);
use Games::Bingo::Column;
use Games::Bingo::ColumnCollection;

my $dump = 0;

my $collection = Games::Bingo::ColumnCollection->new();
my $column = Games::Bingo::Column->new(0, 9);

$collection->add_column($column); #adding column labelled 0

#test 1
is(scalar @{$collection}, 1, 'Testing the size of the collection, pre retrieval');

my $c = $collection->get_column(0, 0, 1);

#test 2
is(scalar @{$collection}, 0, 'Testing the size of the collection, post retrieval');

print STDERR Dumper $collection if $dump;

print STDERR Dumper $c if $dump;