package Games::Bingo;

# $Id: Bingo.pm,v 1.24 2004/01/21 19:48:26 jonasbn Exp $

use strict;
use integer;
use POSIX qw(floor);
use vars qw($VERSION @ISA);
use Games::Bingo::Card;
use Games::Bingo::Constants qw(NUMBER_OF_NUMBERS);

@ISA = qw(Games::Bingo::Card);
$VERSION = '0.10';

sub new {
	my $class = shift;
	my $ceiling = shift || NUMBER_OF_NUMBERS;
	
	my $self = bless {
		_numbers => [],
		_pulled  => [[],[],[],[],[],[],[],[],[],],
		game     => 1,
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
	
	return 1;
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
	$self->pull($number);
	
	return $number;
}

sub pulled {
	my ($self, $number) = @_;
		
	my $found = 0;
	foreach my $n ($self->_all_pulled()) {
		if ($n == $number) {
			$found++;
			last;
		};
	}
		
	if ($found) {
		return 1;
	} else {
		return 0;
	}
}

sub _all_pulled {
	my $self = shift;
	
	my @pulled = ();
	foreach my $row (@{$self->{'_pulled'}}) {		
		foreach my $number (@{$row}) {
			push(@pulled, $number) if $number;
		}
	}
	
	return @pulled;
}

sub pull {
	my ($self, $number) = @_;
	
	return $self->take($self->{'_pulled'}, $number);
}

sub take {
	my ($self, $taken, $take) = @_;

    my ($x, $y, $take_modified) = $self->splitnumber($take);

    return $taken->[$x][$y] = $take_modified;
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

C<< my $bingo = Games::Bingo-E<gt>new(); >>

90 is actually the default

C<< my $number = $bingo-E<gt>play(); >>

C<< my @taken; >>

C<< $bingo-E<gt>pull(\@pulled, $number); >>

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
paramters and then followed by a call to B<init> see below or the
ceiling for the numbers (stored internally) can be given as a
parameter, the latter is the recommeded use.

If no indicator of the number of numbers you want in your bingo game is
given the game defaults to 90. This can be overwritten if using the old
API, please refer to the B<SYNOPSIS>.

The attributes of the class are the following:

=over 4

=item _numbers

The list holding all the numbers in the pull pool.
		
=item _numbers_pulled

A list holding the numbers which have been pulled.
		
=item game

A flag indicating where the game currently are and how it should be run.

These are the different values:

=over 4

=item * 0

Game is over

=item * 1

full card (the default)

=item * 2

2 rows

=item * 3

1 row

=back

=back

=head2 init

This method takes two parameters. An array reference and a ceiling, the
method will push numbers onto the array reference from 1 to ceiling
(including the ceiling). Initializing the numbers for the game.

The use of init is not recommended, use the constructor in the
recommended way instead.

Returns 1 upon success.

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

=head2 pulled

A method which return 1 or 0 indicating true or false, whether the
number given as a parameter has been pulled. 

=cut

=head2 _all_pulled

A method which returns all pulled numbers as an array.

=cut

=head2 pull

A clumsy alias/"overload" implementation of the take method.

=cut

=head1 SEE ALSO

=over 4

=item Games::Bingo::Column

=item Games::Bingo::ColumnCollection

=item Games::Bingo::Print

=item Games::Bingo::Print::Card

=item Games::Bingo::Bot

=item bin/bingo.pl

=back

=cut

=head1 TODO

The TODO file contains a complete list for the whole Games::Bingo
project.

=cut

=head1 AUTHOR

jonasbn E<lt>jonasbn@cpan.orgE<gt>

=cut

=head1 ACKNOWLEDGEMENTS

This is a compilation of all the people have helped me, their names are
scattered all over the modules where appropriate.

=over

=item Rikke Gornitzka for inviting me to the real bingo game, which
started all this

=item Matt Sergeant (MSERGEANT) for suggesting using PDFLib

=item Allan Juul algoritms and code help

=item Michael Legart (LEGART) trying to understand my problems

=item Lars Thegler (THEGLER) for several bug reports

=item Casper Warming (WARMING), for helping with the OSX client

=item The remaining Copenhagen Perl Mongers for testing the IRC game

=item All the ppl who have commented on my journal coming with
suggestions etc.

=back

=cut

=head1 COPYRIGHT

Games::Bingo and related modules are free software and is released under
the Artistic License. See
E<lt>http://www.perl.com/language/misc/Artistic.htmlE<gt> for details.

Games::Bingo is (C) 2003-2004 Jonas B. Nielsen (jonasbn)
E<lt>jonasbn@cpan.orgE<gt>

=cut
