#!/usr/bin/perl -w

# $Id: card_get_all_numbers.t 1864 2007-08-08 09:12:37Z jonasbn $

use strict;
use Test::More tests => 2;

#test 1
BEGIN { use_ok( 'Games::Bingo::Card' ); }

use Games::Bingo::Constants qw(NUMBER_OF_NUMBERS_IN_CARD);

my $card = Games::Bingo::Card->new();
$card->populate();

#test 1
is($card->get_all_numbers(), NUMBER_OF_NUMBERS_IN_CARD, 'Testing get_all_numbers');
