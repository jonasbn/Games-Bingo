#!/usr/local/bin/perl -w

# $Id: flow.t,v 1.3 2003/05/16 09:59:01 jonasbn Exp $

use strict;
use lib qw(lib ../lib);
use Games::Bingo;

my $bingo = Games::Bingo->new(90);

for (my $i = 90; $i > 0; $i--) {
	$bingo->play();
}
