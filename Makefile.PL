use ExtUtils::MakeMaker;

# $Id: Makefile.PL,v 1.3 2003/05/11 15:03:11 jonasbn Exp $

WriteMakefile(
    'NAME'	        => 'Games::Bingo',
    'VERSION_FROM'  => 'lib/Games/Bingo.pm', # finds $VERSION
	'PREREQ_PM' => {
		'POSIX'         => 0,
		'Test::Harness' => 0,
		'Test::More'    => 0,
		'Data::Dumper'  => 0,
		'PDFLib'		=> '0.12',
	}
);
