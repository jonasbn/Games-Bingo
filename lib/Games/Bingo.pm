package Games::Bingo;

# $Id: Bingo.pm,v 1.14 2003/05/16 09:59:01 jonasbn Exp $

use strict;
use integer;
use POSIX qw(floor);
use vars qw($VERSION);

$VERSION = '0.04';

sub new {
	my ($class, $ceiling) = @_;
	
	my $self = bless {
		_numbers => [],
	}, $class || ref $class;

	if ($ceiling) {
		my @ary;
		$self->init(\@ary, $ceiling);
		push @{$self->{'_numbers'}}, @ary; 
	}
	return $self;
}

sub init {
	my ($self, $numbers, $ceiling) = @_;
	
	for(my $i = 1; $i < ($ceiling + 1); $i++) { 
		push @{$numbers}, $i; 
	}
}

sub play {
	my ($self, $numbers) = @_;

	my $number;
	if ($numbers) {
		my $index = $self->random(scalar @{$numbers});
		$number = $numbers->[$index];
		splice(@{$numbers},  $index, 1);	
	} else {	
		my $index = $self->random(scalar @{$self->{'_numbers'}});
		$number = $self->{'_numbers'}->[$index];
		splice(@{$self->{'_numbers'}},  $index, 1);
	}
	return $number;
}

sub take {
	my ($self, $taken, $take) = @_;

    my $take_modified = sprintf("%02d", $take);
    my ($x, $y) = $take_modified =~ m/^(\d{1})(\d{1})$/o;

    $taken->[$x][$y] = $take_modified;
}

sub random {
	my ($self, $number) = @_;

	return POSIX::floor(rand($number));
}

1;

__END__

=head1 NAME

Games::Bingo - a bingo game Perl implementation

=cut

=head1 SYNOPSIS

C<< use Games::Bingo; >>

C<< my $bingo = Games::Bingo-E<gt>new(90); >>

C<< my $number = $bingo-E<gt>play(); >>

C<< my @taken; >>

C<< $bingo-E<gt>take(\@taken, $number); >>

or

C<< use Games::Bingo; >>

C<< my $bingo = Games::Bingo-E<gt>new(); >>

C<< my @numbers; >>

C<< $bingo-E<gt>init(\@numbers, 90); >>

C<< my $number = $bingo-E<gt>play(\@numbers); >>

C<< my @taken; >>

C<< $bingo-E<gt>take(\@taken, $number); >>

=cut

=head1 DESCRIPTION

This is a simple game of bingo. The program can randomly call out the
numbers. The game will be get more features in the future, please refer
to the B<TODO> section (below).

=cut

=head1 METHODS

This are the central methods of Games::Bingo

=head2 new

The constructor is quite simple. It can either be called without any
paramters and then followed by a call to B<init> see below. Or the
ceiling for the numbers (stored internally) can be given as a
parameter, the latter is the recommeded use, please refer to the
B<SYNOPSIS>.

=head2 init

This method takes two parameters. An array reference and a ceiling, the
method will push numbers onto the array reference from 1 to ceiling
(including the ceiling). Initializing the numbers for the game.

The use of init is not recommended, use the constructor in the
recommended way instead.

=head2 play

The B<play> is one of the essential methods in the game, it takes an
array reference and returns a random number from the array referenced
to. The reference shrinks with one with each call.

The recommended way is though to use the internally stored array, where
play then takes no arguments, please refer to B<new> and B<init> and
the B<SYNOPSIS>.

=head2 take

The B<take> method is the memory of the game. It takes to parameters, a
reference to an array of arrays (the memory), and additionaly the number
picked by e.g. the B<play> method.

Since the first program to use the class/module was a console based the
take method organizes the numbers in an array of array for a nicer
presentation. This will probably be changed later (if necessary).

=head2 random

The encapsulation of the rand function. Takes a number as a paramtere
and returns a number between 0 and the number given as a parameter just
as rand (% perldoc -f rand).

The result is rounded down using POSIX::floor

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