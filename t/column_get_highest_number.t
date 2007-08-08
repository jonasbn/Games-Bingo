#!/usr/bin/perl -w

# $Id: column_get_highest_number.t 1864 2007-08-08 09:12:37Z jonasbn $

use strict;
use Test::More tests => 10;

#test 1
BEGIN { use_ok( 'Games::Bingo::Column' ); }

my @numbers = qw(1 2 3 4 5 6 7 8 9);
my $c = Games::Bingo::Column->new(1, @numbers);

for(my $i = scalar(@numbers)-1; $i >= 0; $i--) {
	my $j = $i + 1;
	is($c->get_highest_number(1), $numbers[$i], "expecting $j");
}
