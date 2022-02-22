use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'LibreDWG',
    VERSION_FROM      => 'lib/LibreDWG.pm', # finds $VERSION, requires EU::MM from perl >= 5.5
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ABSTRACT_FROM     => 'lib/LibreDWG.pm', # retrieve abstract from module
    AUTHOR            => 'Dmitry Sinyavin <s0me0ne@s0me0ne.com>',
    #LICENSE           => 'perl',
    #Value must be from legacy list of licenses here
    #https://metacpan.org/pod/Module::Build::API
    LIBS              => ['-lredwg '], # e.g., '-lm'
    DEFINE            => '', # e.g., '-DHAVE_SOMETHING'
    INC               => '-I.', # e.g., '-I. -I/usr/include/other'
	# Un-comment this if you add C files to link with later:
    XSBUILD           => {
        xs => {
            'lib/LibreDWG/API' => {
                OBJECT => 'lib/LibreDWG/API$(OBJ_EXT) perl_math_int64$(OBJ_EXT)'
            }
        }
    },
    OBJECT            => 'perl_math_int64.o', # link all the C files too
    XSMULTI           => 1,
);
