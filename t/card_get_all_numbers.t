#!/usr/bin/perl -w

# $Id: card_get_all_numbers.t,v 1.2 2004/01/06 20:54:01 jonasbn Exp $

use strict;
use Test::More tests => 1;
use lib qw(lib ../lib);
use Games::Bingo::Card;
use Games::Bingo::Constants qw(NUMBER_OF_NUMBERS_IN_CARD);

my $card = Games::Bingo::Card->new();
$card->populate();

#test 1
is($card->get_all_numbers(), NUMBER_OF_NUMBERS_IN_CARD, 'Testing get_all_numbers');
