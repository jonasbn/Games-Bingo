use ExtUtils::MakeMaker;

# $Id: Makefile.PL,v 1.6 2003/07/21 15:17:08 jonasbn Exp $

WriteMakefile(
    'NAME'	        => 'Games::Bingo',
    'VERSION_FROM'  => 'lib/Games/Bingo.pm', # finds $VERSION
	'PREREQ_PM' => {
		'POSIX'         => 0,
		'Test::Harness' => 0,
		'Test::More'    => 0,
		'Test::Pod'     => '0.95',
		'Data::Dumper'  => 0,
	}
);
