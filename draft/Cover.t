#!/usr/local/bin/perl -w

# $Id: Cover.t 1357 2004-05-29 11:16:43Z jonasbn $

use strict;
use lib qw(lib ../lib);
use Games::Bingo;

my $bingo = Games::Bingo->new(90);

for (my $i = 90; $i > 0; $i--) {
	$bingo->play();
}
