package Games::Bingo::Card;

# $Id: Card.pm,v 1.5 2003/07/30 18:51:20 jonasbn Exp $

use strict;
use vars qw($VERSION);
use lib qw(lib ../lib);
use Games::Bingo '0.05';

$VERSION = '0.01';

sub new {
	my ($class, $bingo) = @_;
	
	my $self = bless [], ref $class || $class;

	$self->_generate($bingo);

	return $self;
}

sub _generate {
	my ($self, $bingo) = @_;

	for(my $i = 1; $i < 13; $i++) {
		my $number = $bingo->play();
		push (@{$self}, $number);
	}
}

sub validate {
	my ($self, $bingo) = @_;
	
	my $rv = 0;
	foreach my $number (@{$self}) {
		++$rv if $bingo->pulled($number); 
	}
	
	if ($rv != scalar @{$self}) { 
		return 0;
	} else {
		return 1;
	}
}

1;

__END__

=head1 NAME

Games::Bingo::Card - a helper class for Games::Bingo

=cut

=head1 SYNOPSIS

use Games::Bingo::Card;

my $b = Games::Bingo-E<gt>new(90);

my $card = Games::Bingo::Card-E<gt>new($b);

my $bingo = Games::Bingo-E<gt>new(90);

$card-E<gt>validate($bingo);

=cut

=head2 new

This method generates an object representing a bingo card

=cut

=head2 _generate

This method is called from the constructor, and it the one pulling the
random number for the bingo card, it takes an bingo object as an
argument. This currently holds a flaw, please see the SYNOPSIS and the
TODO file.

=cut

=head2 validate

This method can validate a bingo card against a game. So it easily can
be examined whether a player/card has bingo.

The method takes one argument, the Games::Bingo object of the current game.

This method does not hold the same flaw as the method above though.

=cut

=head1 SEE ALSO

=over 4

=item Games::Bingo

=item Games::Bingo::Bot

=back

=cut

=head1 TODO

The TODO file contains a complete list for the whole Games::Bingo
project.

=cut

=head1 AUTHOR

jonasbn E<lt>jonasbn@cpan.orgE<gt>

=cut

=head1 COPYRIGHT

Games::Bingo::Card and related modules are free software and is released under
the Artistic License. See
E<lt>http://www.perl.com/language/misc/Artistic.htmlE<gt> for details.

Games::Bingo is (C) 2003 Jonas B. Nielsen (jonasbn)
E<lt>jonasbn@cpan.orgE<gt>

=cut