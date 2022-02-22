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

# TBD: SPLINE
# TBD: POLYLINE_PFACE
# TBD: POLYLINE_MESH
# TBD: LEADER
# TBD: MLINE
# TBD: LWPOLYLINE
# TBD: ACSH_CHAMFER_CLASS
# TBD: EVALUATION_GRAPH

sub AUTOLOAD {
	my $self = shift;
	warn "Trying to autoload $AUTOLOAD";

	$AUTOLOAD =~ s/^LibreDWG:://;
	if($AUTOLOAD =~ /^add_(\w+)/) {
		if(any { $1 eq $_ } (qw(DICTIONARY DICTIONARYWDFLT PLACEHOLDER VBA_PROJECT BLOCK_CONTROL BLOCK_HEADER UCS LAYER STYLE LTYPE VIEW DIMSTYLE VPORT VX_TABLE_RECORD APPID GROUP MLINESTYLE PROXY_OBJECT LAYERFILTER LAYER_INDEX SPATIAL_INDEX WIPEOUTVARIABLES))) {
			my $sub = \&{"LibreDWG::API::dwg_add_$1"};
			unshift @_, $self->{dwg};
			return $sub->(@_);
		} elsif(any { $1 eq $_ } (qw(TEXT BLOCK ENDBLK INSERT MINSERT ARC CIRCLE LINE DIMENSION_ALIGNED DIMENSION_ANG2LN DIMENSION_ANG3PT DIMENSION_DIAMETER DIMENSION_ORDINATE DIMENSION_RADIUS DIMENSION_LINEAR POINT 3DFACE SOLID TRACE SHAPE VIEWPORT ELLIPSE REGION 3DSOLID BODY RAY XLINE OLE2FRAME MTEXT TOLERANCE IMAGE LARGE_RADIAL_DIMENSION PDFUNDERLAY BOX CONE CYLINDER EXTRUDED_SOLID EXTRUDED_PATH PYRAMID REVOLVED_SOLID SPHERE TORUS WEDGE PROXY_ENTITY))) {
			my $sub = \&{"LibreDWG::API::dwg_add_$1"};
			unshift @_, $self->{hdr};
			return $sub->(@_);
		} elsif(exists &{"LibreDWG::API::dwg_add_$1"}) {
			my $sub = \&{"LibreDWG::API::dwg_add_$1"};
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
