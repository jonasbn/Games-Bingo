#!/usr/local/bin/perl -w

# $Id: flow.t,v 1.3 2003/05/16 09:59:01 jonasbn Exp $

use strict;
use lib qw(lib ../lib);
use Test::More tests => 180;

use Games::Bingo;

my $bingo = Games::Bingo->new();
my @numbers;

$bingo->init(\@numbers, 90);

for (my $i = 90; $i > 0; $i--) {
	$bingo->play(\@numbers);
	is(scalar @numbers, ($i-1), 'Testing the shrinking of the array');
	
}

my $bingo2 = Games::Bingo->new(90);

for (my $i = 90; $i > 0; $i--) {
	$bingo2->play();
	is(scalar @{$bingo2->{'_numbers'}}, ($i-1), 'Testing the shrinking of the array');
	
}
