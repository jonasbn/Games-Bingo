# $Id: bless.t 1084 2003-12-27 10:27:16Z jonasbn $

use strict;
use Test::More tests => 100;
use lib qw(lib ../lib);
use Games::Bingo::Card;

for (1..100) {

	my $c1 = Games::Bingo::Card->new();
	my ($address1) = sprintf("%s\n", $c1);
	my $c2 = $c1->populate();
	my ($address2) = sprintf("%s\n", $c2);
	is($address1, $address2);
}