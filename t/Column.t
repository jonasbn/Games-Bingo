#!/usr/local/bin/perl -w

# $Id: Column.t,v 1.6 2003/05/08 20:53:05 jonasbn Exp $

use strict;
use lib qw(lib);
use Test::More tests => 30;
use Data::Dumper;

#scenario 1

#test 1-2
BEGIN { use_ok( 'Games::Bingo::Column' ); }
require_ok( 'Games::Bingo::Column' );

my @ary = qw(1 2 3 4 5 6 7 8 9);
my $c = Games::Bingo::Column->new(undef, @ary);

#test 3
is(ref $c, 'Games::Bingo::Column', 'Testing constructor with parameter');

#test 4
is($c->count_numbers, 9, 'Testing the initialized array');

print Dumper $c;

my $k = Games::Bingo::Column->new();

#test 5
is(scalar @{$k->{'_array'}}, 0, 'Testing the initialized array');

print Dumper $k;

$k->populate(1);
#test 6
is($k->count_numbers, 1, 'Testing the initialized array');

my $n = $c->get_random_number();
#test 7
like($n, qr/\d+/, 'Testing the random function');

#test 8
is(scalar @{$c->{'_array'}}, 9, 'Testing the array');

$n = $c->get_random_number(1);
#test 9
like($n, qr/\d+/, 'Testing the random function');

#test 10
is(scalar @{$c->{'_array'}}, 8, 'Testing the array');

my $l = Games::Bingo::Column->new(1, @ary);

#test 11
is($l->{label}, 1, 'Testing the label set in the constructor');

#test 12
is($l->count_numbers, 9, 'Testing the array');

#test 13-21
@ary = qw(1 2 3 4 5 6 7 8 9);
$l = Games::Bingo::Column->new(1, @ary);

while(scalar @{$l->{_array}}) {
	my $n = $l->get_number(1);
	is($n, (pop(@ary)), 'Testing whether we have been sorted'); 
}

#test 22-30
@ary = qw(1 2 3 4 5 6 7 8 9);
$l = Games::Bingo::Column->new(1);
foreach my $r (@ary) {
	$l->populate($r);
}

while(scalar @{$l->{_array}}) {
	my $n = $l->get_number(1);
	is($n, (pop(@ary)), 'Testing whether we have been sorted'); 
}