package Games::Bingo;

# $Id: Bingo.pm,v 1.11 2003/05/14 16:36:11 jonasbn Exp $

use strict;
use integer;
use POSIX qw(floor);
use vars qw($VERSION);

$VERSION = '0.03';

sub new {
	my $class = shift;
	
	my $self = bless {
		_list => [],
	}, $class || ref $class;
}

sub init {
	my $self = shift;
	my $numbers = shift;
	my $ceiling = shift;
	
	for(my $i = 1; $i < ($ceiling + 1); $i++) { push @$numbers, $i; }
}

sub play {
	my $self = shift;
	my $numbers = shift;
	
	my $index = POSIX::floor(rand(scalar @$numbers));
	my $number = $numbers->[$index];
	splice(@$numbers,  $index, 1);
	
	return $number;
}

sub take {
	my $self = shift;
    my $taken = shift;
    my $take = shift;

    my $take_modified = sprintf("%02d", $take);
    my ($x, $y) = $take_modified =~ m/^(\d{1})(\d{1})$/o;

    $taken->[$x][$y] = $take_modified;
}

1;

__END__

=head1 NAME

Games::Bingo - a Bingo Game Perl implementation

=cut

=head1 SYNOPSIS

C<< use Games::Bingo; >>

C<< my $bingo = Games::Bingo-E<gt>new(); >>

C<< my @numbers; >>

C<< $bingo-E<gt>init(\@numbers, 90); >>

C<< my $number = $bingo-E<gt>play(\@numbers); >>

C<< $bingo-E<gt>take(\@taken, $number); >>

=cut

=head1 DESCRIPTION

This is a simple game of bingo. The program can randomly call out the
numbers. The game will be get more features in the future, please refer
to the B<TODO> section (below).

=cut

=head2 METHODS

This are the central methods of Games::Bingo

=head2 new

The constructor is quite simple for now and is only quite proforma, but
will be put to use later.

=head2 init

This method takes two parameters. An array reference and a ceiling, the
method will push numbers onto the array reference from 1 to ceiling
(including the ceiling). Initializing the numbers for the game.

=head2 play

The B<play> is one of the essential methods in the game, it takes an
array reference and returns a random number from the array referenced
to. The reference shrinks with one with each call.

=head2 take

The B<take> method is the memory of the game. It takes to parameters, a
reference to an array of arrays (the memory), and additionaly the number
picked by e.g. the B<play> method.

Since the first program to use the class/module was a console based the
take method organizes the numbers in an array of array for a nicer
presentation. This will probably be changed later (if necessary).

=cut

=head1 SEE ALSO

=over 4

=item Games::Bingo::Column

=item Games::Bingo::ColumnCollection

=item Games::Bingo::Print

=item Games::Bingo::Print::Plate

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