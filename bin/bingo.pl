#!/usr/bin/perl -w

# $Id: bingo.pl,v 1.3 2003/02/28 21:59:48 jonasbn Exp $

use strict;
use lib qw(../lib/ lib);
use Games::Bingo;

my $version = "0.01";

my $bingo = Games::Bingo->new();

my @numbers;
my @taken;

$bingo->init(\@numbers, 90);
init_taken(\@taken);

main();

sub main {
	my $number;
	
	while(scalar @numbers) {

		system("clear");
		print "########################################\n";
		print "           bingo.pl $version\n";
		print "########################################\n";

		show_taken(\@taken);
		
		print "\nNumber = $number\n" if $number;
		print "\nHit <Return> for next number\n";
		my $v = <STDIN>;

		$number = $bingo->play(\@numbers);
		$bingo->take(\@taken, $number);
	}
}

sub init_taken {
	my $taken = shift;

	for (my $j = 0; $j < 10; $j++) {
		for (my $k = 0; $k < 10; $k++) {
			if (($j == 0 and $k == 0) or ($j == 9 and $k > 0)) {
				$taken->[$j][$k] = "    ";
			} else {
				$taken->[$j][$k] = "[  ]";
			}
		}
	}
}

sub show_taken {
	my $taken = shift;

	for (my $m = 0; $m < 10; $m++) {
		for (my $n = 0; $n < 10; $n++) {
			if ($taken->[$m][$n] =~ m/\d+/) {
				print '['.$taken->[$m][$n].']';
			} else {
				print $taken->[$m][$n]; 
			}
		}
		print "\n";
	}
}
