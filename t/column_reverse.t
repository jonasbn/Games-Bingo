#!/usr/bin/perl -w

# $Id: column_reverse.t,v 1.1 2004/01/04 20:05:48 jonasbn Exp $

use strict;
use lib qw(lib);
use Games::Bingo::Column;
use Test::More tests => 9;

my @ary = qw(1 2 3 4 5 6 7 8 9);
my $c = Games::Bingo::Column->new(1, @ary);

while(scalar @{$c->{_array}}) {
	my $n = $c->get_highest_number(1);
	is($n, (pop(@ary)), 'Testing whether we have been sorted'); 
}
