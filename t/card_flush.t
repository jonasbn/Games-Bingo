#!/usr/bin/perl -w

# $Id: card_flush.t 1096 2004-01-06 20:54:01Z jonasbn $

use strict;
use Test::More tests => 3;
use lib qw(lib ../lib);
use Games::Bingo::Card;
use Games::Bingo::Constants qw(NUMBER_OF_NUMBERS_IN_CARD);

my $card = Games::Bingo::Card->new();
$card->populate();

is(scalar $card->get_all_numbers(), NUMBER_OF_NUMBERS_IN_CARD);

ok($card->_flush());

is(scalar $card->get_all_numbers(), 0);
