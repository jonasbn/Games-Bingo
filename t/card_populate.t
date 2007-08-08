#!/usr/local/bin/perl -w

# $Id: card_populate.t 1864 2007-08-08 09:12:37Z jonasbn $

use strict;
use Test::More tests => 3;

BEGIN { use_ok( 'Games::Bingo::Card' ); }

#test 1
my $card = Games::Bingo::Card->new();
ok($card->populate());

#test 2
is($card->_integrity_check(), 1, 'Testing our card integrity');
