#!/usr/local/bin/perl -w

# $Id: Bingo.t,v 1.1 2003/01/03 20:03:23 jonasbn Exp $

use strict;
use lib qw(lib ../lib);
use Test::More tests => 3;
use Data::Dumper;

BEGIN { use_ok( 'Games::Bingo' ); }
require_ok( 'Games::Bingo' );

my $bingo = Games::Bingo->new();

my @numbers;
$bingo->init(\@numbers, 90);

is(scalar @numbers, 90, 'Testing the initialized numbers array');