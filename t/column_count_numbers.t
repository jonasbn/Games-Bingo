#!/usr/bin/perl -w

# $Id: column_count_numbers.t 1090 2004-01-04 20:05:48Z jonasbn $

use strict;
use lib qw(lib);
use Games::Bingo::Column;
use Test::More tests => 2;

#test 1
my $c = Games::Bingo::Column->new();
is($c->count_numbers, 0, 'Testing the initialized array');

#test 2
$c->populate(1);
is($c->count_numbers, 1, 'Testing the populated array');
