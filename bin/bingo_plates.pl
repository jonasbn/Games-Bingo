#!/usr/local/bin/perl -w

# $Id: bingo_plates.pl,v 1.6 2003/05/04 17:50:43 jonasbn Exp $

use strict;
use PDFLib;
use Data::Dumper;

use lib qw(lib ../lib);

use Games::Bingo::Print;

my $pages = shift @ARGV || die "Must supply number of pages\n";

my $bp = Games::Bingo::Print->new();

$bp->print_pages($pages);

exit(0);