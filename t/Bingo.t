#!/usr/local/bin/perl -w

# $Id: Bingo.t,v 1.2 2003/05/16 09:59:01 jonasbn Exp $

use strict;
use lib qw(lib ../lib);
use Test::More tests => 4;
use Data::Dumper;

#test 1-2
BEGIN { use_ok( 'Games::Bingo' ); }
require_ok( 'Games::Bingo' );

#test 3
my $bingo = Games::Bingo->new();

my @numbers;
$bingo->init(\@numbers, 90);
is(scalar @numbers, 90, 'Testing the initialized numbers array');

#test 4
my $bingo2 = Games::Bingo->new(90);
is(scalar @{$bingo2->{'_numbers'}}, 90, 'Testing the initialized numbers array');