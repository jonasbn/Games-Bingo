#!/usr/local/bin/perl -w

# $Id: Bingo.t,v 1.3 2003/06/05 20:12:28 jonasbn Exp $

use strict;
use lib qw(lib ../lib);
use Test::More tests => 6;
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

#test 5
my $number = $bingo2->play();
$bingo2->pull($number);

my @pulled = $bingo2->_all_pulled();
is(scalar @pulled, 1, 'Testing _all_pulled'); 

#test 6
$number = $bingo2->play();
$bingo2->pull($number);

@pulled = $bingo2->_all_pulled();
is(scalar @pulled, 2, 'Testing _all_pulled'); 
