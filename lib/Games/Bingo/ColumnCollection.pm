package Games::Bingo::ColumnCollection;

# $Id: ColumnCollection.pm,v 1.6 2003/05/08 19:17:41 jonasbn Exp $

use strict;
use integer;
use POSIX qw(floor);
use lib qw(lib ../lib);
use Games::Bingo::Column;

sub new ($) {
	my $class = shift;
	
	my $self =  bless [], $class || ref $class;
}

sub divide ($$@) {
	my $self = shift;
	my $number_of_columns = shift;
	my @numbers = @_;

	for (my $number = 0; $number < $number_of_columns; $number++) {
		my @s = ();
		if ($number == 0) {
			@s = splice(@numbers, 0, 9);
		} elsif ($number == 8) {
			@s = splice(@numbers, 0, 11);
		} else {
			@s = splice(@numbers, 0, 10);
		}
		my $column = Games::Bingo::Column->new($number, @s);

		$self->add_column($column);	 
	}
}

sub add_column ($$;$) {
	my $self = shift;
	my $column = shift;
	my $index = shift;
	
	if ($index) {
		$self->[$index] = $column; 
	} else {
		push(@{$self}, $column); 
	}
}

sub _remove_column ($$) {
	my $self = shift;
	my $index = shift;

	splice(@{$self}, $index, 1); 
}

sub get_column ($$;$$) {
	my $self = shift;
	my $index = shift;
	my $do_splice = shift;
	my $auto_splice = shift;
	
	my $column = $self->[$index];
		
	if ($auto_splice and $column) {
		my $length = $column->count_numbers();
		if ($length < 2) {
			$do_splice = 1;
		} else {
			$do_splice = 0;
		}
	}
	
	if ($do_splice) {
		my $v = $self->_remove_column($index);
	}
	return $column;
}

sub get_random_column ($;$$) {
	my $self = shift;
	my $do_splice = shift;
	my $auto_splice = shift;
	
	my $index = POSIX::floor(rand(scalar @{$self}));	
	my $column = $self->get_column($index, $do_splice, $auto_splice);

	return $column;
}

1;

__END__

=head1 NAME

Games::Bingo::ColumnCollection

=cut

=head1 SYNOPSIS

=cut

=pod

=cut

=head1 DESCRIPTION

The ColumnCollection is used when building the bingo plates and is a temporary 
data structure for holding object of the class Column.

The class is an encapsulated array, which is 1 indexed.

=cut

=head1 METHODS

=head2 new ($)

The constructor blesses and array and returns.

=head2 divide ($$@) 

The divided method has nothing as such to do with the class apart from it is a 
helper method, which is used to taking a list of numbers (1-90 expected, see Games::Bingo).

It then divided this list into 9 separate arrays of the following constallations:

=over 4

=item *

1-9

=item *

10-19

=item *

20-29

=item *

30-39

=item *

40-49

=item *

50-59

=item *

60-69

=item *

70-79

=item *

80-90

=back

From these arrays the Columns are built and the column collection is slowly 
populated, when done the column collection is returned.

=cut

=head2 add_column ($$)

This is a push like method, is can be used to add an additional to the collection.

=head2 remove_column ($$)

The method can remove a column specified by its index, the argument specifies 
this index.

=head2 get_column ($$)

The method returns a column specified by its index, the argument to this method 
is the index.

The second argument is an indicator of whether the returned collection should be 
removed from the list, B<1> for removed and B<0> for not removing, the latter is 
the default.

=head2 get_random_column ($;$)

This method returns a random columns, the optional parameter can be used to indicate 
whether the column should be removed from the list. B<1> indicates a removed and 
nothing (the default) that nothing should be done.

=head2 reset_columns ($$)

The method uses the fact that the class contains Columns and a bit of polymorphy, 
so this method can be used to set the status of all Columns contained in the class. '
The parameter is the status which you want to set, either B<1> or B<0>.

=head1 SEE ALSO

=over 4

=item *

Games::Bingo

=item *

Games::Bingo::Column

=back

=head1 TODO

The TODO file contains a complete list for the whole Games::Bingo project.

=head1 AUTHOR

jonasbn <jonasbn@io.dk>

=head1 ACKNOWLEDGEMENTS

My friend Allan helped me out with some of the algoritmic stuff and was in when 
this class was thought up.

=head1 COPYRIGHT

Games::Bingo and related modules are free software and is released under the 
Artistic License. See <http://www.perl.com/language/misc/Artistic.html> for 
details.

Games::Bingo is (C) 2003 Jonas B. Nielsen (jonasbn) <jonasbn@io.dk>

=cut