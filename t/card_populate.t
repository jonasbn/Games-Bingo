#!/usr/local/bin/perl -w

# $Id: card_populate.t 1136 2004-01-21 19:48:26Z jonasbn $

use strict;
use lib qw(lib ../lib);
use Games::Bingo::Card;
use Test::More tests => 2;

#test 1
my $card = Games::Bingo::Card->new();
ok($card->populate());

#test 2
is($card->_integrity_check(), 1, 'Testing our card integrity');
