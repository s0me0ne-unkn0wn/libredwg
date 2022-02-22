package LibreDWG;

use Carp qw(croak);
use List::Util qw(any);
use vars '$AUTOLOAD';

use LibreDWG::API;

use DDP;

# TODO: Re-implement dwg_read_file and its siblings in perl code to make use of IO::Handle features
sub new {
	my $class = shift;
	my %opt = @_ == 1 ? (filename => shift) : @_;
	# croak "`fh' is provided and `format' is not" if $opt{fh} && !$opt{format};
	if($opt{filename} && !$opt{format}) {
		$opt{filename} =~ /([^\.]+)$/;
		$opt{format} = lc($1);
	}
	croak "Unknown input format `$opt{format}'" if $opt{filename} && !(any { $_ eq $opt{format} } (qw(dwg dxf json)));

	my $dwg;
	
	if($opt{filename}) {
		if($opt{format} eq 'dwg') {
			$dwg = LibreDWG::API::_dwg_new();
			my $err = LibreDWG::API::dwg_read_file($opt{filename}, $dwg);
			p $dwg;
			croak "Reading $opt{filename}: error $err" if $err >= LibreDWG::API::DWG_ERR_CRITICAL;
		} elsif($opt{format} eq 'dxf') {
			die 'Reading DXF is not implemented yet';
		} elsif($opt{format} eq 'json') {
			die 'Reading JSON is not implemented yet';
		}
	} else {
		$dwg = LibreDWG::API::dwg_add_Document(24, 0, 9);
	}

	my $mspace_hdr = LibreDWG::API::_dwg_get_mspace_BLOCK_HEADER($dwg);
	p $mspace_hdr;
	my $self = bless {
		%opt,
		dwg => $dwg,
		hdr => $mspace_hdr,
		mspace_hdr => $mspace_hdr,
		pspace_hdr => LibreDWG::API::_dwg_get_pspace_BLOCK_HEADER($dwg),
	}, $class;
}

sub write_file {
	my $self = shift;
	my %opt = @_ == 1 ? (filename => shift) : @_;

	if($opt{filename} && !$opt{format}) {
		$opt{filename} =~ /([^\.]+)$/;
		$opt{format} = lc($1);
	}
	croak "Unknown output format `$opt{format}'" unless any { $_ eq $opt{format} } (qw(dwg dxf json));

	p $self->{dwg};
	my $err = LibreDWG::API::dwg_write_file($opt{filename}, $self->{dwg});
	croak "Writing $opt{filename}: error $err" if $err >= LibreDWG::API::DWG_ERR_CRITICAL;
}

sub add_POLYLINE_2D {
	my ($self, $pts) = @_;
	LibreDWG::API::dwg_add_POLYLINE_2D($self->{hdr}, scalar(@$pts), $pts);
}

sub add_POLYLINE_3D {
	my ($self, $pts) = @_;
	LibreDWG::API::dwg_add_POLYLINE_3D($self->{hdr}, scalar(@$pts), $pts);
}

sub AUTOLOAD {
	my $self = shift;
	warn "Trying to autoload $AUTOLOAD";

	$AUTOLOAD =~ s/^LibreDWG:://;
	if($AUTOLOAD =~ /^add_(\w+)/) {
		if(exists &{"LibreDWG::API::dwg_add_$1"}) {
			warn "calling LibreDWG::API::dwg_add_$1";
			my $sub = \&{"LibreDWG::API::dwg_add_$1"};
			unshift @_, $self->{hdr};
			p @_;
			return $sub->(@_);
		}
	}

	$self->${\"NEXT::$AUTOLOAD"}(@_);
}

sub DESTROY {
	my $self = shift;

	LibreDWG::API::_dwg_destroy($self->{dwg}) if defined $self->{dwg};
}

1;
