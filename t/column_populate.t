#!/usr/bin/perl -w

# $Id: column_populate.t,v 1.1 2004/01/04 20:05:48 jonasbn Exp $

use strict;
use Test::More tests => 20;

#test 1
use_ok( 'Games::Bingo::Column' );

my @ary = qw(1 2 3 4 5 6 7 8 9);
my $c = Games::Bingo::Column->new();

my $i = 0;

#test 1
is($c->count_numbers, $i, 'Testing the initialized array');

#tests 2-19
foreach my $n (@ary) {
	ok($c->populate($n));
	is($c->count_numbers, ++$i, 'Testing the populated array');
}