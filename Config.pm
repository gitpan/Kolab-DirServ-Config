package Kolab::DirServ::Config;

use 5.008;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Kolab::DirServ::Config ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	%dirserv_config @addressbook_peers
);

our $VERSION = '0.03';
use vars qw(%dirserv_config @routing_peers @addressbook_peers);
use IO::File;
use Kolab::Config;

# Preloaded methods go here.
%dirserv_config = ();
@addressbook_peers = ();

my $fd;

my $dirserv_conf = $kolab_prefix."/etc/kolab/dirserv.conf";
if ($fd = IO::File->new($dirserv_conf, "r")) { foreach (<$fd>) {
   if (/(.*) : (.*)/) { 
      $dirserv_config{$1} = $2; 
      #print "$1 $2\n";
   }
}
undef $fd;
} else {
 warn "could not open $dirserv_conf";
}

my $addressbook_peers = $kolab_prefix."/etc/kolab/addressbook.peers";
if ($fd = IO::File->new($addressbook_peers, "r")) { 
   foreach (<$fd>) {
   my $peer = $_;
   chomp($peer);
   $peer =~ s/\#.+$//;
   $peer =~ s/\s//g;
   if ($peer ne "") { 
     push(@addressbook_peers, ($peer));
   }
}
undef $fd;
} else {
  warn "could not open $addressbook_peers";
}

$dirserv_config{'notify_from'} || warn "could not read notify_from from $dirserv_conf";


1;
__END__

=head1 NAME

Kolab::DirServ::Config - A Perl Module that acts as a standard interface to the
configuration settings of a Kolab server.

=head1 SYNOPSIS

  use Kolab::DirServ::Config;
  
  #The address that address book notifications are sent from
  print $dirserv_conf{'notify_from'};

  #Print a list of address book peers
  print join(" ", @addressbook_peers);

=head1 ABSTRACT

  The Kolab::DirServ::Config module provides a standard interface to 
  access Address Book replication parameters.
  
=head1 DESCRIPTION

This module provides a standard interface through which to retrieve 
address book replication information.

The peers are populated from $kolab_prefix/etc/kolab/addressbook.peers
Configuration is read from $kolab_prefix/etc/kolab/dirserv.conf

=head2 EXPORT

  @addressbook_peers   
    A perl list that contains a list of e-mail addresses which are to
    recieve update notifications. 
    Built from $kolab_prefix/etc/kolab/addressbook.peers
  
  %dirserv_conf        
    A hash that contains configuration parameters used by the service.
    Built from $kolab_prefix/etc/kolab/dirserv.con
  
=head1 SEE ALSO

kolab-devel mailing list: <kolab-devel@lists.intevation.org>

Kolab website: http://kolab.kroupware.org

=head1 AUTHOR

Stephan Buys, s.buys@codefusion.co.za

Please report any bugs, or post any suggestions, to the kolab-devel
mailing list <kolab-devel@lists.intevation.de>.
       

=head1 COPYRIGHT AND LICENSE

Copyright 2003 by Stephan Buys

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
