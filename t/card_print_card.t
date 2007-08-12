#!/usr/bin/perl -w

# $Id: card_print_card.t 1869 2007-08-12 15:52:36Z jonasbn $

use strict;
use Test::More tests => 2;

use_ok( 'Games::Bingo::Card' );

my $card = Games::Bingo::Card->new();
$card->populate();

ok($card->_print_card());
