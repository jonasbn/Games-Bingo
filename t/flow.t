#!/usr/local/bin/perl -w

# $Id: flow.t,v 1.2 2003/01/03 20:16:55 jonasbn Exp $

use strict;
use lib qw(lib ../lib);
use Test::More tests => 90;

use Games::Bingo;

my $bingo = Games::Bingo->new();

my @taken;
my @numbers;

$bingo->init(\@numbers, 90);

for (my $i = 90; $i > 0; $i--) {
	$bingo->play(\@numbers);
	is(scalar @numbers, ($i-1), 'Testing the shrinking of the array');
	
}
