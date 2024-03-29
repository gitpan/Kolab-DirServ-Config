use 5.008;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'Kolab::DirServ::Config',
    'VERSION_FROM'	=> 'Config.pm', # finds $VERSION
    'PREREQ_PM'		=> {
       'Kolab::Config' => '>0.1',
    }, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'Config.pm', # retrieve abstract from module
       AUTHOR     => 'root <root@(none)>') : ()),
);
