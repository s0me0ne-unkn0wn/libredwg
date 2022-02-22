package LibreDWG::API;

use strict;
use warnings;

use constant DWG_NOERR => 0;

use constant DWG_ERR_WRONGCRC         => 1;
use constant DWG_ERR_NOTYETSUPPORTED  => 1 << 1;
use constant DWG_ERR_UNHANDLEDCLASS   => 1 << 2;
use constant DWG_ERR_INVALIDTYPE      => 1 << 3;
use constant DWG_ERR_INVALIDHANDLE    => 1 << 4;
use constant DWG_ERR_INVALIDEED       => 1 << 5;
use constant DWG_ERR_VALUEOUTOFBOUNDS => 1 << 6;

use constant DWG_ERR_CLASSESNOTFOUND  => 1 << 7;
use constant DWG_ERR_SECTIONNOTFOUND  => 1 << 8;
use constant DWG_ERR_PAGENOTFOUND     => 1 << 9;
use constant DWG_ERR_INTERNALERROR    => 1 << 10;
use constant DWG_ERR_INVALIDDWG       => 1 << 11;
use constant DWG_ERR_IOERROR          => 1 << 12;
use constant DWG_ERR_OUTOFMEM         => 1 << 13;

use constant DWG_ERR_CRITICAL					=> 1 << 7;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use LibreDWG::API ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our $VERSION = '0.01';

require XSLoader;
XSLoader::load('LibreDWG::API', $VERSION);

# Preloaded methods go here.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

LibreDWG::API - Perl extension for blah blah blah

=head1 SYNOPSIS

  use LibreDWG::API;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for LibreDWG::API, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.


=head1 HISTORY

=over 8

=item 0.01

Original version; created by h2xs 1.23 with options

  -n
	LibreDWG::API
	-A
	-C
	dwg_api.h
	-lredwg

=back



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

Someone Unknown, E<lt>s0me0ne@E<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2022 by Someone Unknown

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.32.1 or,
at your option, any later version of Perl 5 you may have available.


=cut
