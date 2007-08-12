#!/usr/bin/perl -w

# $Id: column_count_numbers.t 1869 2007-08-12 15:52:36Z jonasbn $

use strict;
use Test::More tests => 3;

#test 1
use_ok( 'Games::Bingo::Column' );

#test 1
my $c = Games::Bingo::Column->new();
is($c->count_numbers, 0, 'Testing the initialized array');

#test 2
$c->populate(1);
is($c->count_numbers, 1, 'Testing the populated array');
