package Games::Bingo::Card;

# $Id: Card.pm,v 1.14 2004/01/21 19:48:26 jonasbn Exp $

use strict;
use integer;
use Data::Dumper;
use vars qw($VERSION);
use lib qw(lib ../lib);
use Games::Bingo;
use Games::Bingo::Column;
use Games::Bingo::ColumnCollection;
use Games::Bingo::Constants qw(
	NUMBER_OF_NUMBERS_IN_CARD
	NUMBER_OF_COLUMNS_IN_CARD
	NUMBER_OF_ROWS_IN_CARD
	NUMBER_OF_NUMBERS_IN_ROW
	NUMBER_OF_NUMBERS
);

$VERSION = '0.02';

sub new {
	my ($class) = @_;
	
	my $self = bless [], ref $class || $class; 
	
	return $self;
}

sub get_all_numbers {
	my $self = shift;
	
	my @numbers = ();
	foreach my $row (@{$self}) {		
		foreach my $number (@{$row}) {
			push(@numbers, $number) if $number;
		}
	}
	return @numbers;
}

sub splitnumber {
	my ($self, $number) = @_;
	
	my $modified = sprintf("%02d", $number);
    my ($x, $y) = $modified =~ m/^(\d{1})(\d{1})$/o;

	return ($x, $y, $modified);
}

sub validate {
	my ($self, $bingo) = @_;
	
	my $rv = 0;
	my $trv = undef;
	if ($bingo->{game} > 2) {
		#not implemented yet
		$trv = 4;
	} elsif ($bingo->{game} > 1) {
		#not implemented yet
		$trv = 8;
	} elsif ($bingo->{game} > 0) {
		my @numbers = $self->get_all_numbers();
		
		foreach my $number (@numbers) {
			++$rv if $bingo->pulled($number); 
		}
		$trv = NUMBER_OF_NUMBERS_IN_CARD;
	} else {
		warn "bingo game not defined?\n";
	}
	
	if ($rv == $trv) { 
		$bingo->{game}--;
		return 1;
	} else {
		return 0;
	}
}

sub _print_card {
	my $self  = shift;

	my $row = 0;
	for (my $m = 0; $m < 7; $m++) {
		my $column = 0;
		
		if ($m%2) {
			for (my $n = 1; $n < 20; $n++) {
				if ($n%2) {
					print "|";
				} else {
					if ($self->[$column][$row]) {
						printf("%2d",$self->[$column][$row]);
					} else {	
						print "  ";
					}
					++$column;
				}
			}
			$row++;
		} else {
			for (my $n = 1; $n < 20; $n++) {
				if ($n%2) {
					print "+";
				} else {
					print "--";
				}
			}
		}
		print "\n";
	}
	return 1;
}

sub _insert {
	my ($self, $row, $number) = @_;
	
	my $column = $self->_resolve_column($number);	
	$self->[$column]->[$row] = $number;

	return 1;
}

sub _integrity_check {
	my ($self) = @_;
	
	my $rv = NUMBER_OF_NUMBERS_IN_CARD;
	foreach my $row (@{$self})	{
		foreach my $cell (@{$row}) {
			if ($cell) {
				if ($cell =~ m/^\d+$/o) {
					$rv--;
				}
			}
		} 
	}
	if ($rv != 0) {
		return 0;
	} else {
		return 1;
	}
}

sub _resolve_column {
	my ($self, $number) = @_;
	
	my $result = ($number / 10);
	my ($column) = $result =~ m/^(\d{1})$/o;
		
	if ($result < 1) { #ones go in column 0
		$column = 0;
	} elsif ($result == NUMBER_OF_COLUMNS_IN_CARD) { #9 go in column 8
		$column = 8; 	
	}
	return $column;
}

sub _init {
	my ($self) = @_;
		
	my @numbers;
	my $bingo = Games::Bingo->new();
	$bingo->init(\@numbers, NUMBER_OF_NUMBERS);

	#Creating the numeric set to pick from
	my $temp_collection = Games::Bingo::ColumnCollection->new();
	$temp_collection->divide(NUMBER_OF_COLUMNS_IN_CARD, @numbers);
	
	my $final_collection = Games::Bingo::ColumnCollection->new();
	
	#Getting the first 9 numbers
	for (my $i = 0; $i < NUMBER_OF_COLUMNS_IN_CARD; $i++) {
		my $c = $temp_collection->get_column($i);
		my $n = $c->get_random_number(1);

		my $fc = Games::Bingo::Column->new($i);
		$fc->populate($n);
		
		$final_collection->add_column($fc);
	}

	#Getting the 3 extras so we have 12 numbers
	for (my $i = NUMBER_OF_NUMBERS_IN_CARD 
			- NUMBER_OF_COLUMNS_IN_CARD; $i > 0; $i--) {
		my $tc = $temp_collection->get_random_column(1);
		my $n = $tc->get_random_number(1);
		my $label = $tc->{label};	
		
		my $fc = $final_collection->get_column($label);
				
		$fc->populate($n);
	}			
	return $final_collection;
}

sub populate {
	my ($self) = @_;

	HACK:
	
	my $fcc = $self->_init();
		
	for (my $row = NUMBER_OF_ROWS_IN_CARD-1; $row >= 0; $row--) {
		my $tcc = Games::Bingo::ColumnCollection->new();

		for (my $i = NUMBER_OF_NUMBERS_IN_ROW; $i > 0; $i--) {

			my $c = $fcc->get_random_column(1);			
			my $number = $c->get_highest_number(1);
						
			if ($c->count_numbers() > 0) {
					$fcc->add_column($c);
			} else {
				#implicitly discarding empty columns
			} 		
			$self->_insert($row, $number);					
		}
		foreach my $column (@${fcc}) {
			$tcc->add_column($column);
		}		
		$fcc = $tcc;		
	}	
	my $amount = scalar $self->get_all_numbers();
	
	unless ($self->_integrity_check) {
		
		warn "Incomplete trying again... ($amount)\n";
		
		#if the integrity check fails, meaning we don not have 
		#enough numbers to  print a card we simply try again,
		#please refer to the BUGS file or the B<BUGS> section below.
		
		$self = $self->_flush;
		
		goto HACK;	
	}		
	return $self;
}

sub _flush {
	my $self = shift;
		
	@{$self} = ();
	
	return $self;
}

1;

__END__

=head1 NAME

Games::Bingo::Card - a helper class for Games::Bingo

=cut

=head1 SYNOPSIS

C<< use Games::Bingo::Card; >>

C<< my $b = Games::Bingo-E<gt>new(90); >>

C<< my $card = Games::Bingo::Card-E<gt>new($b); >>

C<< my $bingo = Games::Bingo-E<gt>new(90); >>

C<< $card-E<gt>validate($bingo); >>

C<< use Games::Bingo::Print::Card; >>

C<< my $p = Games::Bingo::Print::Card-E<gt>new(); >>

C<< $p-E<gt>populate(); >>

=cut

=head1 DESCRIPTION

The Games::Bingo::Card class suits the simple purpose of being able to
generate bingo cards and validating whether they are valid in during a
game where a player indicate victory.

It is also used by Games::Bingo::Print to hold the generated bingo
cards before they are printed.

=cut

=head1 METHODS

=cut

=head2 new

This method generates an object representing a bingo card.

The constructor, takes no arguments.

=cut

=head2 populate

This method is the main method of the class. It populates the card
objects with a predefined number of randomly picked numbers which can
be printed using the Games::Bingo::Print class.

=cut

=head2 _init

Init uses the function in Games::Bingo::Column and
Games::Bingo::ColumnCollection, which are use to generate the necessary
random numbers to generate the card and set the them in the necessary
columns.

=cut

=head2 _insert

This is the private method which is used to insert numbers onto the
card in the Bingo::Games::Card class.

Populate takes to arguments, the row and the number, it resolves the
column using B<_resolve_column>.

=head2 _resolve_column

Resolve column is method used to resolve where on the card a specified
number should go. It takes a number and returns an integer indicating a
column.

=head2 _integrity_check

This method is a part of the work-around, which was made in the
B<populate> method, it checks whether the populated card holds 12
numbers return a boolean value indicating succes or failure.

=head2 validate

This method can validate a bingo card against a game. So it easily can
be examined whether a player/card has bingo.

The method takes one argument, the Games::Bingo object of the current game.

This method does not hold the same flaw as the method above though.

=head2 _print_card

This is the console version of the _print_card version, which is
implemented in B<Games::Bingo::Print>. 

It prints the generated card with numbers.

=head2 _flush

This method can be used to flush the contents of the Card object.

=head1 BUGS

This class contains a bug in B<populate>, which is regarded a design
flaw. A work-around have implemented. See the BUGS file.

There is also a bug in B<_print>

No other bugs are known at the time of writing.

=head1 SEE ALSO

=over 4

=item Games::Bingo

=item Games::Bingo::Bot

=item Games::Bingo::Column

=item Games::Bingo::Column::Collection

=item Games::Bingo::Constants

=item Games::Bingo::Print

=back

=head1 TODO

The TODO file contains a complete list for the whole Games::Bingo
project.

=head1 AUTHOR

jonasbn E<lt>jonasbn@cpan.orgE<gt>

=cut

=head1 COPYRIGHT

Games::Bingo::Card and related modules are free software and is released under
the Artistic License. See
E<lt>http://www.perl.com/language/misc/Artistic.htmlE<gt> for details.

Games::Bingo is (C) 2003-2004 Jonas B. Nielsen (jonasbn)
E<lt>jonasbn@cpan.orgE<gt>

=cut