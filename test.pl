#!/usr/local/bin/perl -w

# $Id: test.pl,v 1.3 2003/05/03 10:27:19 jonasbn Exp $

use strict;
use DirHandle;
use Test::Harness;
use Getopt::Long;
use Pod::Usage;

my $verbose = 0;
my $simple  = 0;
my $man     = 0;
my $help    = 0;
my $testdir = 't';
my @tests   = ();

GetOptions(
    'help|?'    => \$help,
	"man"       => \$man,
	"testdir=s" => \$testdir,
	"verbose"   => \$verbose,
	"simple"    => \$simple,
);

pod2usage( -exitstatus => 0, -verbose => 2 ) if $man;
pod2usage(1) if ($help and (! $simple));

print "Looking for tests in test dir: $testdir\n" if ($verbose);

if (scalar @ARGV) {
	foreach my $file (@ARGV) {
		print "Found test: $file\n" if ($verbose);
		&append(\$file, \@tests, \$testdir);
	}
} else {
	opendir(DH, $testdir) or die "Couldn't open $testdir for reading: $!";
	while(defined (my $file = readdir(DH)) ) {
    	next unless $file =~ m/^\w+\.[t]$/io;
		&append(\$file, \@tests, \$testdir);
	}
}

if ($simple) {
	foreach my $test (@tests) {
		print "\nRunning: $test\n\n";
		system("perl  $test");
	}
} else {
	runtests(@tests);
}

exit;

sub append {
	my $file = shift;
	my $tests = shift;
	my $testdir = shift;

	my $filename = "$$testdir/$$file";
	push(@$tests, $filename);

	return 1;
}

__END__

=head1 NAME

test.pl - Runs tests 

=head1 SYNOPSIS

test.pl [options] -- [testfiles]

=head1 OPTIONS

=over 8

=item B<-verbose>

More information will be displayed during processing. This might not be necessary due to the verbosity of the actual test data. 

=item B<-testdir>

This is the test directory in which test.pl will look for test files (files ending on .t. If not given t/ will be assumed.

=item B<-simple>

The simple flag sets test.pl to run Test::Simple script to be run so their own information is displayed (normally suppressed by Test::Harness). Test::Simple scripts do also work under Test::Harness.

=item B<-help>

Prints a brief help message and exits.

=item B<-man>

Prints the manual page and exits.

=back

=head1 DESCRIPTION

B<This program> will read the given input file(s) and run any tests in these.

So write your normal test files using Test or Test::Simple. This script gives you a more flexible interface to testing during development. You can tell the script what directory your tests are in (-testdir). You can specify whether you want to have Test::Simple output (I need to takes this with Michael Schwern at some point). Or you can specify which test files you want processed by listing them after the options (--).

So all you need to do is follow the normal Perl test writing conventions and then abuse this tool.

=head1 AUTHOR

jonasbn <jonasbn@wanadoo.dk>

=head1 BUGS

No known bugs. 

=head1 SEE ALSO

=over 8

=item Test::Simple

=item Test::Harness

=back

=head1 COPYRIGHT

Copyright (c) 2001 Jonas B. Nielsen. All rights
reserved.  This program is free software; you can
redistribute it and/or modify it under the same 
terms as Perl itself.

=cut
