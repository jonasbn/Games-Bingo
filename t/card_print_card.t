#!/usr/bin/perl -w

# $Id: card_print_card.t,v 1.2 2004/01/06 20:54:01 jonasbn Exp $

use strict;
use Test::More tests => 1;
use lib qw(lib ../lib);
use Games::Bingo::Card;

my $card = Games::Bingo::Card->new();
$card->populate();

ok($card->_print_card());
