# $Id$

use Module::Build;

Module::Build->new( 
	module_name => 'Games::Bingo',
	license => 'perl',
	dist_version_from => 'lib/Games/Bingo.pm',
	requires => { 
		'POSIX'         => 0,
		'Test::Harness' => 0,
		'Test::More'    => 0,
		'Test::Pod'     => '0.95',
		'Data::Dumper'  => 0,
	},
)->create_build_script;