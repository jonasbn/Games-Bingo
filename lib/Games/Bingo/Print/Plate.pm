package Games::Bingo::Print::Plate;

# $Id: Plate.pm,v 1.3 2003/05/09 19:39:45 jonasbn Exp $

use strict;
use integer;
use lib qw(lib ../lib);
use Games::Bingo;
use Games::Bingo::Column;
use Games::Bingo::ColumnCollection;

sub new ($) {
	my $class = shift;
	
	my $self = bless [
		["  ", "  ", "  "],
		["  ", "  ", "  "],
		["  ", "  ", "  "],
		["  ", "  ", "  "],
		["  ", "  ", "  "],
		["  ", "  ", "  "],
		["  ", "  ", "  "],
		["  ", "  ", "  "],
		["  ", "  ", "  "],
	], $class || ref $class;
	
	return $self;
}

sub _populate ($$$) {
	my ($self, $row, $number) = @_;
		
	my $column = $self->_resolve_column($number);
	
	$self->[$column]->[$row] = $number;
}

sub _integrity_check ($) {
	my ($self) = @_;

	my $rv = 12;
	foreach my $row (@{$self})	{
		foreach my $cell (@{$row}) {
			if ($cell =~ m/^\d+$/o) {
				$rv--;
			}
		} 
	}
	if ($rv != 0) {
		return 0;
	} else {
		return 1;
	}
}

sub _resolve_column ($$) {
	my ($self, $number) = @_;
	
	my $result = ($number / 10);
	my ($column) = $result =~ m/^(\d{1})$/o;
		
	if ($result < 1) { #ones go in 0 column
		$column = 0;
	} elsif ($result == 9) { #9 go in column 8
		$column = 8; 	
	}

	return $column;
}

sub _init ($) {
	my ($self) = @_;
	
	my @numbers;
	my $bingo = Games::Bingo->new();
	$bingo->init(\@numbers, 90);

	#Creating the numeric set to pick from
	my $temp_collection = Games::Bingo::ColumnCollection->new();
	$temp_collection->divide(9, @numbers);
	
	my $final_collection = Games::Bingo::ColumnCollection->new();
	
	#Getting the first 9 numbers
	for (my $i = 0; $i < 9; $i++) {
		my $c = $temp_collection->get_column($i);
		my $n = $c->get_random_number(1);

		my $fc = Games::Bingo::Column->new($i);
		$fc->populate($n);
		$final_collection->add_column($fc);
	}

	#Getting the 3 extras so we have 12 numbers
	for (my $i = 3; $i > 0; $i--) {
		my $c = $temp_collection->get_random_column(1);
		my $n = $c->get_random_number(1);
	
		my $fc = $final_collection->get_column($c->{label});
		$fc->populate($n);
	}
	return $final_collection;
}

sub populate ($) {
	my ($self) = @_;

	HACK: 
	
	my $final_collection = $self->_init();
	
	my $n = 0;
	for (my $row = 0; $row < 3; $row++) {
		my $temp_plate_collection = Games::Bingo::ColumnCollection->new();

		for (my $i = 0; $i < 4; $i++) {
			my $c = $final_collection->get_random_column(1);			
			my $number = $c->get_number();
			
			if ($c->count_numbers > 0) {
				if ($row != 2) {
					$temp_plate_collection->add_column($c);
				} elsif ($row == 2) {
					$final_collection->add_column($c);
				}
			}
			$self->_populate($row, $number);					
		}
		foreach my $column (@${final_collection}) {
			$temp_plate_collection->add_column($column);
		}		
		$final_collection = $temp_plate_collection;		
	}
	
	unless ($self->_integrity_check) {
		warn "Incomplete trying again...\n";
		
		#if the integrity check fails, meaning we don not have 
		#enough numbers to  print a plate we simply try again,
		#please refer to the BUGS file.
		
		$self = (ref $self)->new();
		goto HACK;
	}
	return $self;
 }

1;

__END__

=head1 NAME

Games::Bingo::Print::Plate

=head1 SYNOPSIS

use Games::Bingo::Print::Plate;

C<<my $p = Games::Bingo::Print::Plate->new();>>

C<<$p->populate();>>

=head1 DESCRIPTION

This Games::Bingo::Print::Plate class (Plate for now) is a simple holder used 
to hold the generated bingo plates before they are printed.

=head2 METHODS

=over 4

=item new

The constructor, takes no arguments.

=item populate

This method is the main method of the class. It populates the object with a 
plate of 12 random numbers which can be printed using the Games::Bingo::Print
class.

=item _init

Init uses the function in Games::Bingo::Column and 
Games::Bingo::ColumnCollection, which are use to generate the necessary random 
numbers to generate the plate and set the them in the necessary columns.

=item _populate

This is the private method which is used to populate the plate in the Plate 
class.

Populate takes to arguments, the row and the number, it resolves the column using B<_resolve_column>.

=item _resolve_column

Resolve column is method used to resolve where on the plate a specified number 
should go. It takes a number and returns an integer indicating a column.

=item _integrity_check

This method is a part of the work-around, which was made in the B<populate> 
method, it checks whether the populated Plate holds 12 numbers return a boolean 
value indicating succes or failure.

=back

=head1 BUGS

This class contains a bug in B<populate>, which is regarded a design flaw. 
A work around have implemented. No other bugs are known at the time of writing.

=head1 SEE ALSO

=over 4

=item Games::Bingo

=item Games::Bingo::Column

=item Games::Bingo::Column::Collection

=item Games::Bingo::Print

=back

=head1 AUTHOR

jonasbn <jonasbn@io.dk>

=head1 COPYRIGHT

Games::Bingo and related modules are free software and is released under the 
Artistic License. See <http://www.perl.com/language/misc/Artistic.html> for 
details.

Games::Bingo is (C) 2003 Jonas B. Nielsen (jonasbn) <jonasbn@io.dk>

=cut