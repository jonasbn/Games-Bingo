#!/usr/bin/perl -w

# $Id: column_get_highest_number.t,v 1.1 2004/01/04 20:05:48 jonasbn Exp $

use strict;
use lib qw(lib ../lib);
use Games::Bingo::Column;
use Test::More tests => 9;

my @numbers = qw(1 2 3 4 5 6 7 8 9);
my $c = Games::Bingo::Column->new(1, @numbers);

for(my $i = scalar(@numbers)-1; $i >= 0; $i--) {
	my $j = $i + 1;
	is($c->get_highest_number(1), $numbers[$i], "expecting $j");
}
