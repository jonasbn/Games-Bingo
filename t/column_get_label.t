#!/usr/bin/perl -w

# $Id: column_new.t 1090 2004-01-04 20:05:48Z jonasbn $

use strict;
use lib qw(lib);
use Games::Bingo::Column;
use Test::More tests => 1;

my @ary = qw(1 2 3 4 5 6 7 8 9);
my $c = Games::Bingo::Column->new(1, @ary);

#test 3
is($c->get_label(), 1);
