

use strict;
use Module::Build;

my $build = Module::Build->new(
	dist_author       => 'Jonas B. Nielsen, <jonasbn@cpan.org>',
	dist_name         => 'Games-Bingo',
	dist_version_from => 'lib/Games/Bingo.pm',
	license           => 'perl',
	scripts => {
		'bin/bingo.pl' => 'bin/bingo.pl',
	},
	recursive_test_files => 1,
	requires => {
			'POSIX'         => 0,
			'Test::Pod'     => '0.95',
			'Test::Harness' => 0, #core
			'Test::More'    => 0, #core
			'Data::Dumper'  => 0, #core
			'UNIVERSAL'     => 0, #core
			'Carp'          => 0, #core
			'perl'          => '5.6.0', #5.006
	},
	no_index => {
		directory => ['t'],
		file      => ['t/MyBingo.pm'],
	},
	create_makefile_pl => 'traditional',
);
$build->create_build_script();
