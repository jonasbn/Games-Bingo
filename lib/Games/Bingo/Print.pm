package Games::Bingo::Print;

# $Id: Print.pm,v 1.6 2003/05/13 15:28:51 jonasbn Exp $

use strict;
use integer;
use PDFLib;

use lib qw(lib ../lib);
use Games::Bingo::Print::Plate;

sub new {
	my ($class) = @_;
	
	my $pdf = PDFLib->new(
	    filename  => 'bingo.pdf',
   	    papersize => 'a4',
        creator   => 'Jonas B. Nielsen',
        author    => 'Jonas B. Nielsen',
        title     => 'Bingo!',
    );

	my $self = bless{
		'pdf' => $pdf,
	}, $class || ref $class;
}

sub print_pages {
	my ($self, $pages) = @_;
	
	my $pdf = $self->{'pdf'};
	
	foreach my $i (1..$pages) {
  
    	$pdf->start_page;
    	$pdf->set_font(
    	    face => 'Helvetica',
    	    size => 40,
    	    bold => 1
    	);
    	$pdf->print_boxed(
    	    'Games::Bingo',
    	    mode => 'center',
    	    'x' => 0,
    	    'y' => 740,
    	    'w' => 595,
    	    'h' => 50
    	);
    	$pdf->set_font(
    	    face => 'Helvetica',
    	    size => 12,
    	    bold => 1
    	);
    	$pdf->print_boxed(
    	    'by jonasbn <jonasbn@io.dk>',
    	    'mode' => 'center',
    	    'x' => 0,
    	    'y' => 685,
    	    'w' => 595,
    	    'h' => 50
    	);

		my $y_start_cordinate = 50;
		my $x_start_cordinate = 30;
		my $size = 60;
		my $yec;
		my $psize = $size * 3;
		for (my $p = 1; $p <= 3; $p++) {
			$yec = $y_start_cordinate + $psize;
				
			$self->_print_plate(
						size              => $size,
						x_start_cordinate => $x_start_cordinate,
						y_start_cordinate => $y_start_cordinate,
						y_end_cordinate   => $yec,
			);
			$y_start_cordinate = $yec + 50;
    	}
	}
	$pdf->stroke;
	$pdf->finish;
}

sub _print_plate {
	my $self = shift;
	my %args = @_;

	my $pdf = $self->{'pdf'};

	my $p = Games::Bingo::Print::Plate->new();
	$p = $p->populate();
	
	my $ysc  = $args{'y_start_cordinate'};
	my $yec  = $args{'y_end_cordinate'};
	my $xsc  = $args{'x_start_cordinate'};
	my $size = $args{'size'};
	
	my $y = 1;
	for (my $ry = $ysc; $ry < $yec; $ry += $size) {
		my @numbers;
		for (my $x = 0; $x <= 9; $x++) {
			push(@numbers, $p->[$x-1]->[$y-1]);
		}		
		$self->_print_row(
				  size 			    => $size,
			      x_start_cordinate => $xsc,
			      y_start_cordinate => $ry,
			      x_end_cordinate   => 540,
			      numbers 		    => \@numbers,
		);
		$y++;
	}
}

sub _print_row {
	my $self = shift;
	my %args = @_;
	
	my $pdf = $self->{'pdf'};
	
	my $ysc     = $args{'y_start_cordinate'};
	my $xsc     = $args{'x_start_cordinate'};
	my $xec     = $args{'x_end_cordinate'};
	my $size    = $args{'size'};
	my $numbers = $args{'numbers'};
	
	my $x;
	for (my $rx = $xsc; $rx <= $xec; $rx += $size) {
		++$x;
		my $label = $numbers->[$x];
		
		$pdf->rect(
		    'x' => $rx,
		    'y' => $ysc,
		    'w' => $size,
		    'h' => $size
		);
		$pdf->stroke;
		$pdf->set_font(
		    face => 'Helvetica',
		    size => 40,
		    bold => 1
		);
 	   	$pdf->print_at(
 	   	    $label, 
 	   	    'mode' => 'center',
 	   	    'x' => $rx+1,
 	   	    'y' => $ysc+10
 	   	);

	}
}

1;

__END__

=head1 NAME

Games::Bingo - PDF Generation Class

=cut

=head1 SYNOPSIS

C<< use Games::Bingo::Print; >>

C<< my $bp = Games::Bingo::Print-E<gt>new(); >>

C<< $bp-E<gt>print_pages(2); >>

=cut

=head1 DESCRIPTION

This is that actual printing class. It generates PDFs with Bingo plates on them.

=cut

=head1 METHODS

=head2 new

The constructor

=head2 print_pages

The print pages is the main method it takes one argument, the number of pages you 
want to print a page currently contains 3 separate bingo plates.

It calls B<_print_plate>.

=head2 _print_plate

This is the method used to print the actual plate, it calls print row 3 times.

=over 4

=item *

y_start_cordinate

The B<Y> start cordinate (we print botton up for now).

=item *

y_end_cordinate

The B<Y> end cordinate (we print botton up for now).

=item *

x_start_cordinate

The B<X> start cordinate (we print botton up for now).

=item *

size

The pixel size of the box containg the number,

=back

=head2 _print_row

This method prints a single row.

=over 4
	
=item *

y_start_cordinate

The B<Y> start cordinate (we print botton up for now).

=item *

x_start_cordinate

The B<X> start cordinate (we print botton up for now).

=item *

x_end_cordinate

The B<X> end cordinate (we print botton up for now),

=item *

size

The pixel size of the box containg the number,

=item *

numbers

The numbers to be insertet into the row as an reference to an array.

=back

=cut

=head1 SEE ALSO

=over 4

=item PDFLib

=item Games::Bingo::Print::Plate

=item bin/bingo_plates.pl

=back

=head1 TODO

The TODO file contains a complete list for the whole Games::Bingo
project.

=cut

=head1 AUTHOR

jonasbn E<lt>jonasbn@io.dkE<gt>

=cut

=head1 ACKNOWLEDGEMENTS

Thanks to Matt Seargent for suggesting using PDFLib.

=cut

=head1 COPYRIGHT

Games::Bingo and related modules are free software and is released under
the Artistic License. See
E<lt>http://www.perl.com/language/misc/Artistic.htmlE<gt> for details.

Games::Bingo is (C) 2003 Jonas B. Nielsen (jonasbn)
E<lt>jonasbn@io.dkE<gt>

=cut