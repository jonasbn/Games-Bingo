#!/usr/local/bin/perl -w

# $Id: ColumnCollection.t,v 1.8 2003/05/16 09:59:01 jonasbn Exp $

use strict;
use lib qw(lib ../lib);
use Test::More tests => 23;
use Data::Dumper;
use Games::Bingo::Column;

my $dump = 0;

#scenario 1
#Basic methods and functionality 1-2

BEGIN { use_ok( 'Games::Bingo::ColumnCollection' ); }
require_ok( 'Games::Bingo::ColumnCollection' );

#test 3
my $col = Games::Bingo::ColumnCollection->new();
like($col, qr/Games::Bingo::ColumnCollection/, 'Testing the constructor');

my $c1 = Games::Bingo::Column->new(0, [1, 2, 3, 4, 5, 6, 7, 8, 9]);
my $c2 = Games::Bingo::Column->new(1, [11, 12, 13, 14, 15, 16, 17, 18, 19]);
my $c3 = Games::Bingo::Column->new(2, [21, 22, 23, 24, 25, 26, 27, 28, 29]);

#test 4
$col->add_column($c1);
is(scalar @{$col}, 1, 'Testing the contents of the collection after addition, we should have 1 element');

#test 5
$col->add_column($c2);
is(scalar @{$col}, 2, 'Testing the contents of the collection after addition, we should have 2 elements');

#test 6
$col->add_column($c3);
is(scalar @{$col}, 3, 'Testing the contents of the collection after addition, we should have 3 elements');

print STDERR Dumper $col if $dump;

#test 7
$col->_remove_column(2);
is(scalar @{$col}, 2, 'Testing the contents of the collection after removal, we should have to elements, ');

#test 8
my $d = $col->get_column(1);
is((ref $d), 'Games::Bingo::Column', 'Testing the contents of the collection, we should get a column');

#test 9
my $e = $col->get_random_column();
is((ref $e), 'Games::Bingo::Column', 'Testing the contents of the collection, we should get a random column');

#scenario 2
#The internal self-maintenance of the collection

#test 10
$col = Games::Bingo::ColumnCollection->new();
my $c = Games::Bingo::Column->new(0, [9]);
$col->add_column($c);

is(scalar @{$col}, 1, 'Testing the setup for the second scenario');

#test 11
$c = undef;
$c = $col->get_random_column(1);
is(scalar @{$col}, 0, 'Testing the remove column');

#test 12
is(ref $c, 'Games::Bingo::Column', 'Checking the extracted element');

#test 13
my $col2 = Games::Bingo::ColumnCollection->new($c1, $c2, $c3);
is(scalar @{$col2}, 3, 'Testing the remove column');

#test 14
is(@!, 0, 'Testing no warnings have been issued');
my $cu = $col2->get_column(-1);

#test 15
is((ref $cu), "", 'Testing undef has been returned');

#test 16
like(@!, qr/\w+/, 'Testing that a warning is issued');

#test 17
$cu = $col2->get_column(10);

#test 18
is((ref $cu), "", 'Testing undef has been returned');

#test 19
like(@!, qr/\w+/, 'Testing that a warning is issued');

#test 20
is(@!, 0, 'Testing no warnings have been issued');
my $cu2 = $col2->_remove_column(-1);

#test 21
is((ref $cu), "", 'Testing undef has been returned');

#test 22
like(@!, qr/\w+/, 'Testing that a warning is issued');

#test 23
$cu2 = $col2->_remove_column(10);

#test 24
is((ref $cu), "", 'Testing undef has been returned');

#test 25
like(@!, qr/\w+/, 'Testing that a warning is issued');