#!/usr/bin/perl -w

# $Id: card_print_card.t 1864 2007-08-08 09:12:37Z jonasbn $

use strict;
use Test::More tests => 2;

BEGIN { use_ok( 'Games::Bingo::Card' ); }

my $card = Games::Bingo::Card->new();
$card->populate();

ok($card->_print_card());
