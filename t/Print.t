#!/usr/local/bin/perl -w

# $Id$

use strict;
use Data::Dumper;
use lib qw(../lib lib);

use Test::More tests => 4;

BEGIN { use_ok( 'Games::Bingo::Print'); }
require_ok( 'Games::Bingo::Print' );

#new
my $bp = Games::Bingo::Print->new();
is(ref $bp, 'Games::Bingo::Print', 'Testing the constructor');

is(ref $bp->{'pdf'}, 'PDFLib', 'Testing the constructor (pdf)');

#_print_row

#_print_plate

#print_pages