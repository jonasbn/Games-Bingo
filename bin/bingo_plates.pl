#!/usr/local/bin/perl -w

# $Id: bingo_plates.pl,v 1.7 2003/05/14 16:35:00 jonasbn Exp $

use strict;
use PDFLib;
use Data::Dumper;

use lib qw(lib ../lib);

use Games::Bingo::Print;

my $pages = shift @ARGV || die "Must supply number of pages\n";

my $bp = Games::Bingo::Print->new();

$bp->print_pages($pages);

exit(0);

__END__

=head1 NAME

bingo_plates.pl

=cut

=head1 SYNOPSIS

% bingo_plates.pl 3

% bingo_plates.pl 10

=cut

=head1 DESCRIPTION

This is a console based PDF bingo plates.pl generator. Together with
bingo.pl you have everything you need to play bingo.

=cut

=head1 SEE ALSO

=over 4

=item Games::Bingo

=item bin/bingo.pl

=back

=cut

=head1 TODO

The TODO file contains a complete list for the whole Games::Bingo
project.

=cut

=head1 AUTHOR

jonasbn E<gt>jonasbn@io.dkE<lt>

=cut

=head1 COPYRIGHT

Games::Bingo and related modules are free software and is released under
the Artistic License. See
E<lt>http://www.perl.com/language/misc/Artistic.htmlE<gt> for details.

Games::Bingo is (C) 2003 Jonas B. Nielsen (jonasbn)
E<gt>jonasbn@io.dkE<lt>

=cut