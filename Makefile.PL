use ExtUtils::MakeMaker;

# $Id: Makefile.PL,v 1.5 2003/06/05 20:12:27 jonasbn Exp $

WriteMakefile(
    'NAME'	        => 'Games::Bingo',
    'VERSION_FROM'  => 'lib/Games/Bingo.pm', # finds $VERSION
	'PREREQ_PM' => {
		'POSIX'         => 0,
		'Test::Harness' => 0,
		'Test::More'    => 0,
		'Test::Pod'     => '0.95',
		'Data::Dumper'  => 0,
		'PDFLib'		=> '0.12',
	}
);
