#!/usr/local/bin/perl -w

# $Id$

use strict;
use Data::Dumper;
use lib qw(../lib lib);

use Test::More tests => 2;

BEGIN { use_ok( 'Games::Bingo::Print::Plate'); }
require_ok( 'Games::Bingo::Print::Plate' );

my $dump = 0;

#Testing the constructor and the constructed object

my $p = Games::Bingo::Print::Plate->new();
$p->populate();

print STDERR Dumper $p if $dump;