#!/usr/local/bin/perl -w

use strict;
use Data::Dumper;
use Test::More tests => 2;

use lib qw(lib ../lib);
use Games::Bingo::Column;
use Games::Bingo::ColumnCollection;

my $dump = 0;

my $collection = Games::Bingo::ColumnCollection->new();
my $column = Games::Bingo::Column->new(0, 1, 2);

$collection->add_column($column); #adding column labelled 0

is(scalar @{$collection}, 1, 'Testing the size of the collection, pre retrieval');

print STDERR Dumper $collection if $dump;

my $c = $collection->get_column(0, 0, 1);

$c->get_number(1);

$c = $collection->get_column(0, 0, 1);

is(scalar @{$collection}, 0, 'Testing the size of the collection, post retrievals');

print STDERR Dumper $collection if $dump;

print STDERR Dumper $c if $dump;