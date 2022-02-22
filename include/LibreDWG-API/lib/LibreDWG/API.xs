#define PERL_NO_GET_CONTEXT
#define MATH_INT64_NATIVE_IF_AVAILABLE

#include "EXTERN.h"
#include "perl.h"
#include "embed.h"
#include "XSUB.h"
#include "perl_math_int64.h"

#include "../../include/dwg.h"
#include "../../include/dwg_api.h"

typedef dwg_point_3d *dwg_point_3d_vec;
typedef dwg_point_2d *dwg_point_2d_vec;

MODULE = LibreDWG::API	PACKAGE = LibreDWG::API
PROTOTYPES: DISABLE

BOOT:
	PERL_MATH_INT64_LOAD_OR_CROAK;

Dwg_Data *
_dwg_new()
	CODE:
		{
			Dwg_Data *dwg;
			Newxz(dwg, 1, Dwg_Data);
			RETVAL = dwg;
		}
	OUTPUT:
		RETVAL

void
_dwg_destory(dwg)
		Dwg_Data *dwg
	CODE:
		{
			Safefree(dwg);
		}

int
dwg_read_file(filename, dwg)
		char *filename
		Dwg_Data *dwg

Dwg_Data *
dwg_add_Document(version, imperial, loglevel)
		Dwg_Version_Type version
		int imperial
		int loglevel

Dwg_Object *
dwg_model_space_object(dwg);
		Dwg_Data *dwg


Dwg_Object_BLOCK_HEADER *
_dwg_get_mspace_BLOCK_HEADER(dwg)
		Dwg_Data *dwg
	CODE:
		{
			Dwg_Object *mspace = dwg_model_space_object(dwg);
			RETVAL = mspace->tio.object->tio.BLOCK_HEADER;
		}
	OUTPUT:
		RETVAL

Dwg_Object_BLOCK_HEADER *
_dwg_get_pspace_BLOCK_HEADER(dwg)
		Dwg_Data *dwg
	CODE:
		{
			Dwg_Object *pspace = dwg_paper_space_object(dwg);
			RETVAL = pspace->tio.object->tio.BLOCK_HEADER;
		}
	OUTPUT:
		RETVAL

int
dwg_write_file(filename, dwg)
	char *filename
	Dwg_Data *dwg

# The following declarations was generated from pre-processed dwg_api.h with multiline comments removed:
# cat tmp1.h \
# |perl -pE 's/(?<!;)\n//' \
# |perl -pE 's|/\*.*?\*/||g; s/\bconst\b//g; s/__nonnull_all//g; s/__nonnull\s*\(\([\d\s,]*\)\)//g; s/\*\s*restrict/*/g; s/[\t ]+/ /g; s/^EXPORT\s+//' \
# |perl -nE 's/^([^\*]+\*)//; my $rettype=$1; s/(\(.*\))//; my $args = $1; my $func = $_; $func=~s/\s*;\s*$//; $args=~s/^\(\s*//; $args=~s/\s*\)\s*$//; @args=split /\s*,\s*/, $args; @names = map { /(\w+)$/; $1 } @args; $rettype=~s/(?<=\S)\*/ */; say "\n$rettype"; say "$func(" . join(", ", @names) . ")"; say $_ for map { s/\*\s+/*/; s/(?<=\S)\*/ */; "\t\t$_" } @args;'

Dwg_Entity_TEXT *
dwg_add_TEXT(blkhdr, text_value, ins_pt, height)
		Dwg_Object_BLOCK_HEADER *blkhdr
		char *text_value
		dwg_point_3d *ins_pt
		double height

Dwg_Entity_ATTRIB *
dwg_add_Attribute(insert, height, flags, prompt, ins_pt, tag, text_value)
		Dwg_Entity_INSERT *insert
		double height
		int flags
		char *prompt
		dwg_point_3d *ins_pt
		char *tag
		char *text_value

Dwg_Entity_BLOCK *
dwg_add_BLOCK(blkhdr, name)
		Dwg_Object_BLOCK_HEADER *blkhdr
		char *name

Dwg_Entity_ENDBLK *
dwg_add_ENDBLK(blkhdr)
		Dwg_Object_BLOCK_HEADER *blkhdr

Dwg_Entity_INSERT *
dwg_add_INSERT(blkhdr, ins_pt, name, xscale, yscale, zscale, rotation)
		Dwg_Object_BLOCK_HEADER *blkhdr
		dwg_point_3d *ins_pt
		char *name
		double xscale
		double yscale
		double zscale
		double rotation

Dwg_Entity_MINSERT *
dwg_add_MINSERT(blkhdr, ins_pt, name, xscale, yscale, zscale, rotation, num_rows, num_cols, row_spacing, col_spacing)
		Dwg_Object_BLOCK_HEADER *blkhdr
		dwg_point_3d *ins_pt
		char *name
		double xscale
		double yscale
		double zscale
		double rotation
		int num_rows
		int num_cols
		double row_spacing
		double col_spacing

Dwg_Entity_POLYLINE_2D *
dwg_add_POLYLINE_2D(blkhdr, num_pts, pts)
		Dwg_Object_BLOCK_HEADER *blkhdr
		int num_pts
		dwg_point_2d_vec pts

Dwg_Entity_POLYLINE_3D *
dwg_add_POLYLINE_3D(blkhdr, num_pts, pts)
		Dwg_Object_BLOCK_HEADER *blkhdr
		int num_pts
		dwg_point_3d_vec pts

# Dwg_Entity_POLYLINE_PFACE *
# dwg_add_POLYLINE_PFACE(blkhdr, numverts, numfaces, verts, faces)
# 		Dwg_Object_BLOCK_HEADER *blkhdr
# 		unsigned numverts
# 		unsigned numfaces
# 		dwg_point_3d *verts
# 		dwg_face *faces


Dwg_Entity_POLYLINE_MESH *
dwg_add_POLYLINE_MESH(blkhdr, num_m_verts, num_n_verts, verts)
		Dwg_Object_BLOCK_HEADER *blkhdr
		unsigned num_m_verts
		unsigned num_n_verts
		dwg_point_3d_vec verts

Dwg_Entity_ARC *
dwg_add_ARC(blkhdr, center, radius, start_angle, end_angle)
		Dwg_Object_BLOCK_HEADER *blkhdr
		dwg_point_3d *center
		double radius
		double start_angle
		double end_angle

Dwg_Entity_CIRCLE *
dwg_add_CIRCLE(blkhdr, center, radius)
		Dwg_Object_BLOCK_HEADER *blkhdr
		dwg_point_3d *center
		double radius

Dwg_Entity_LINE *
dwg_add_LINE(blkhdr, start_pt, end_pt)
		Dwg_Object_BLOCK_HEADER *blkhdr
		dwg_point_3d *start_pt
		dwg_point_3d *end_pt

Dwg_Entity_DIMENSION_ALIGNED *
dwg_add_DIMENSION_ALIGNED(blkhdr, xline1_pt, xline2_pt, text_pt)
		Dwg_Object_BLOCK_HEADER *blkhdr
		dwg_point_3d *xline1_pt
		dwg_point_3d *xline2_pt
		dwg_point_3d *text_pt

Dwg_Entity_DIMENSION_ANG2LN *
dwg_add_DIMENSION_ANG2LN(blkhdr, center_pt, xline1end_pt, xline2end_pt, text_pt)
		Dwg_Object_BLOCK_HEADER *blkhdr
		dwg_point_3d *center_pt
		dwg_point_3d *xline1end_pt
		dwg_point_3d *xline2end_pt
		dwg_point_3d *text_pt

Dwg_Entity_DIMENSION_ANG3PT *
dwg_add_DIMENSION_ANG3PT(blkhdr, center_pt, xline1_pt, xline2_pt, text_pt)
		Dwg_Object_BLOCK_HEADER *blkhdr
		dwg_point_3d *center_pt
		dwg_point_3d *xline1_pt
		dwg_point_3d *xline2_pt
		dwg_point_3d *text_pt

Dwg_Entity_DIMENSION_DIAMETER *
dwg_add_DIMENSION_DIAMETER(blkhdr, chord_pt, far_chord_pt, leader_len)
		Dwg_Object_BLOCK_HEADER *blkhdr
		dwg_point_3d *chord_pt
		dwg_point_3d *far_chord_pt
		double leader_len

Dwg_Entity_DIMENSION_ORDINATE *
dwg_add_DIMENSION_ORDINATE(blkhdr, def_pt, leader_endpt, use_x_axis)
		Dwg_Object_BLOCK_HEADER *blkhdr
		dwg_point_3d *def_pt
		dwg_point_3d *leader_endpt
		bool use_x_axis

Dwg_Entity_DIMENSION_RADIUS *
dwg_add_DIMENSION_RADIUS(blkhdr, center_pt, chord_pt, leader_len)
		Dwg_Object_BLOCK_HEADER *blkhdr
		dwg_point_3d *center_pt
		dwg_point_3d *chord_pt
		double leader_len

Dwg_Entity_DIMENSION_LINEAR *
dwg_add_DIMENSION_LINEAR(blkhdr, xline1_pt, xline2_pt, def_pt, rotation_angle)
		Dwg_Object_BLOCK_HEADER *blkhdr
		dwg_point_3d *xline1_pt
		dwg_point_3d *xline2_pt
		dwg_point_3d *def_pt
		double rotation_angle

Dwg_Entity_POINT *
dwg_add_POINT(blkhdr, pt)
		Dwg_Object_BLOCK_HEADER *blkhdr
		dwg_point_3d *pt

Dwg_Entity__3DFACE *
dwg_add_3DFACE(blkhdr, pt1, pt2, pt3, pt4)
		Dwg_Object_BLOCK_HEADER *blkhdr
		dwg_point_3d *pt1
		dwg_point_3d *pt2
		dwg_point_3d *pt3
		dwg_point_3d *pt4

Dwg_Entity_SOLID *
dwg_add_SOLID(blkhdr, pt1, pt2, pt3, pt4)
		Dwg_Object_BLOCK_HEADER *blkhdr
		dwg_point_3d *pt1
		dwg_point_2d *pt2
		dwg_point_2d *pt3
		dwg_point_2d *pt4

Dwg_Entity_TRACE *
dwg_add_TRACE(blkhdr, pt1, pt2, pt3, pt4)
		Dwg_Object_BLOCK_HEADER *blkhdr
		dwg_point_3d *pt1
		dwg_point_2d *pt2
		dwg_point_2d *pt3
		dwg_point_2d *pt4

Dwg_Entity_SHAPE *
dwg_add_SHAPE(blkhdr, name, ins_pt, scale, oblique_angle)
		Dwg_Object_BLOCK_HEADER *blkhdr
		char *name
		dwg_point_3d *ins_pt
		double scale
		double oblique_angle

Dwg_Entity_VIEWPORT *
dwg_add_VIEWPORT(blkhdr, name)
		Dwg_Object_BLOCK_HEADER *blkhdr
		char *name

Dwg_Entity_ELLIPSE *
dwg_add_ELLIPSE(blkhdr, center, major_axis, axis_ratio)
		Dwg_Object_BLOCK_HEADER *blkhdr
		dwg_point_3d *center
		double major_axis
		double axis_ratio

Dwg_Entity_SPLINE *
dwg_add_SPLINE(blkhdr, num_fit_pts, fit_pts, beg_tan_vec, end_tan_vec)
		Dwg_Object_BLOCK_HEADER *blkhdr
		int num_fit_pts
		dwg_point_3d_vec fit_pts
		dwg_point_3d *beg_tan_vec
		dwg_point_3d *end_tan_vec

Dwg_Entity_REGION *
dwg_add_REGION(blkhdr, acis_data)
		Dwg_Object_BLOCK_HEADER *blkhdr
		char *acis_data

Dwg_Entity_3DSOLID *
dwg_add_3DSOLID(blkhdr, acis_data)
		Dwg_Object_BLOCK_HEADER *blkhdr
		char *acis_data

Dwg_Entity_BODY *
dwg_add_BODY(blkhdr, acis_data)
		Dwg_Object_BLOCK_HEADER *blkhdr
		char *acis_data

Dwg_Entity_RAY *
dwg_add_RAY(blkhdr, point, vector)
		Dwg_Object_BLOCK_HEADER *blkhdr
		dwg_point_3d *point
		dwg_point_3d *vector

Dwg_Entity_XLINE *
dwg_add_XLINE(blkhdr, point, vector)
		Dwg_Object_BLOCK_HEADER *blkhdr
		dwg_point_3d *point
		dwg_point_3d *vector

Dwg_Object_DICTIONARY *
dwg_add_DICTIONARY(dwg, name, text, absolute_ref)
		Dwg_Data *dwg
		char *name
		char *text
		unsigned long absolute_ref

Dwg_Object_DICTIONARY *
dwg_add_DICTIONARY_item(_obj, text, absolute_ref)
		Dwg_Object_DICTIONARY *_obj
		char *text
		unsigned long absolute_ref

Dwg_Object_DICTIONARYWDFLT *
dwg_add_DICTIONARYWDFLT(dwg, name, text, absolute_ref)
		Dwg_Data *dwg
		char *name
		char *text
		unsigned long absolute_ref

Dwg_Entity_OLE2FRAME *
dwg_add_OLE2FRAME(blkhdr, pt1, pt2)
		Dwg_Object_BLOCK_HEADER *blkhdr
		dwg_point_3d *pt1
		dwg_point_3d *pt2

Dwg_Entity_MTEXT *
dwg_add_MTEXT(blkhdr, ins_pt, rect_width, text_value)
		Dwg_Object_BLOCK_HEADER *blkhdr
		dwg_point_3d *ins_pt
		double rect_width
		char *text_value

Dwg_Entity_LEADER *
dwg_add_LEADER(blkhdr, num_points, points, associated_annotation, type)
		Dwg_Object_BLOCK_HEADER *blkhdr
		unsigned num_points
		dwg_point_3d_vec points
		Dwg_Entity_MTEXT *associated_annotation
		unsigned type

Dwg_Entity_TOLERANCE *
dwg_add_TOLERANCE(blkhdr, text_value, ins_pt, x_direction)
		Dwg_Object_BLOCK_HEADER *blkhdr
		char *text_value
		dwg_point_3d *ins_pt
		dwg_point_3d *x_direction

Dwg_Entity_MLINE *
dwg_add_MLINE(blkhdr, num_verts, verts)
		Dwg_Object_BLOCK_HEADER *blkhdr
		unsigned num_verts
		dwg_point_3d_vec verts

Dwg_Entity_LWPOLYLINE *
dwg_add_LWPOLYLINE(blkhdr, num_pts2d, pts2d)
		Dwg_Object_BLOCK_HEADER *blkhdr
		int num_pts2d
		dwg_point_2d *pts2d

# Dwg_Entity_HATCH *
# dwg_add_HATCH(blkhdr, pattern_type, name, is_associative, num_paths, pathobjs)
# 		Dwg_Object_BLOCK_HEADER *blkhdr
# 		int pattern_type
# 		char *name
# 		bool is_associative
# 		unsigned num_paths
# 		Dwg_Object * *pathobjs

Dwg_Object_XRECORD *
dwg_add_XRECORD(dict, keyword)
		Dwg_Object_DICTIONARY *dict
		char *keyword

Dwg_Object_XRECORD *
dwg_add_XRECORD_bool(_obj, dxf, value)
		Dwg_Object_XRECORD *_obj
		short dxf
		BITCODE_B value

Dwg_Object_XRECORD *
dwg_add_XRECORD_int8(_obj, dxf, value)
		Dwg_Object_XRECORD *_obj
		short dxf
		BITCODE_RC value

Dwg_Object_XRECORD *
dwg_add_XRECORD_int16(_obj, dxf, value)
		Dwg_Object_XRECORD *_obj
		short dxf
		BITCODE_BS value

Dwg_Object_XRECORD *
dwg_add_XRECORD_int32(_obj, dxf, value)
		Dwg_Object_XRECORD *_obj
		short dxf
		BITCODE_BL value

Dwg_Object_XRECORD *
dwg_add_XRECORD_int64(_obj, dxf, value)
		Dwg_Object_XRECORD *_obj
		short dxf
		BITCODE_BLL value

Dwg_Object_XRECORD *
dwg_add_XRECORD_real(_obj, dxf, value)
		Dwg_Object_XRECORD *_obj
		short dxf
		BITCODE_BD value

Dwg_Object_XRECORD *
dwg_add_XRECORD_pointd3d(_obj, dxf, pt)
		Dwg_Object_XRECORD *_obj
		short dxf
		dwg_point_3d *pt
	CODE:
		RETVAL = dwg_add_XRECORD_pointd3d(_obj, dxf, (BITCODE_3DPOINT *)pt);
	OUTPUT:
		RETVAL

Dwg_Object_XRECORD *
dwg_add_XRECORD_binary(_obj, dxf, size, data)
		Dwg_Object_XRECORD *_obj
		short dxf
		int size
		BITCODE_RC *data

Dwg_Object_XRECORD *
dwg_add_XRECORD_string(_obj, dxf, len, str)
		Dwg_Object_XRECORD *_obj
		short dxf
		BITCODE_BS len
		char *str

Dwg_Object_XRECORD *
dwg_add_XRECORD_handle(_obj, dxf, hdl)
		Dwg_Object_XRECORD *_obj
		short dxf
		Dwg_Handle hdl

Dwg_Object_PLACEHOLDER *
dwg_add_PLACEHOLDER(dwg)
		Dwg_Data *dwg

Dwg_Object_VBA_PROJECT *
dwg_add_VBA_PROJECT(dwg, size, data)
		Dwg_Data *dwg
		BITCODE_BL size
		BITCODE_RC *data

Dwg_Object_LAYOUT *
dwg_add_LAYOUT(vp, name, canonical_media_name)
		Dwg_Object *vp
		char *name
		char *canonical_media_name

Dwg_Entity_IMAGE *
dwg_add_IMAGE(blkhdr, file_path, ins_pt, scale_factor, rotation_angle)
		Dwg_Object_BLOCK_HEADER *blkhdr
		char *file_path
		dwg_point_3d *ins_pt
		double scale_factor
		double rotation_angle

Dwg_Entity_LARGE_RADIAL_DIMENSION *
dwg_add_LARGE_RADIAL_DIMENSION(blkhdr, center_pt, first_arc_pt, ovr_center, jog_point, leader_len)
		Dwg_Object_BLOCK_HEADER *blkhdr
		dwg_point_3d *center_pt
		dwg_point_3d *first_arc_pt
		dwg_point_3d *ovr_center
		dwg_point_3d *jog_point
		double leader_len

Dwg_Entity_PDFUNDERLAY *
dwg_add_PDFUNDERLAY(blkhdr, filename, ins_pt, scale_factor, rotation_angle)
		Dwg_Object_BLOCK_HEADER *blkhdr
		char *filename
		dwg_point_3d *ins_pt
		double scale_factor
		double rotation_angle

Dwg_Object_ACSH_BOX_CLASS *
dwg_add_ACSH_BOX_CLASS(evalgraph, origin_pt, normal, length, width, height)
		Dwg_Object_EVALUATION_GRAPH *evalgraph
		dwg_point_3d *origin_pt
		dwg_point_3d *normal
		double length
		double width
		double height

Dwg_Object_ACSH_CHAMFER_CLASS *
dwg_add_ACSH_CHAMFER_CLASS(evalgraph, origin_pt, normal, bl92, base_dist, other_dist, num_edges, edges, bl95)
		Dwg_Object_EVALUATION_GRAPH *evalgraph
		dwg_point_3d *origin_pt
		dwg_point_3d *normal
		int bl92
		double base_dist
		double other_dist
		int num_edges
		int32_t *edges
		int bl95

Dwg_Object_ACSH_CONE_CLASS *
dwg_add_ACSH_CONE_CLASS(evalgraph, origin_pt, normal, height, major_radius, minor_radius, x_radius)
		Dwg_Object_EVALUATION_GRAPH *evalgraph
		dwg_point_3d *origin_pt
		dwg_point_3d *normal
		double height
		double major_radius
		double minor_radius
		double x_radius

Dwg_Object_ACSH_CYLINDER_CLASS *
dwg_add_ACSH_CYLINDER_CLASS(evalgraph, origin_pt, normal, height, major_radius, minor_radius, x_radius)
		Dwg_Object_EVALUATION_GRAPH *evalgraph
		dwg_point_3d *origin_pt
		dwg_point_3d *normal
		double height
		double major_radius
		double minor_radius
		double x_radius

Dwg_Object_ACSH_PYRAMID_CLASS *
dwg_add_ACSH_PYRAMID_CLASS(evalgraph, origin_pt, normal, height, sides, radius, topradius)
		Dwg_Object_EVALUATION_GRAPH *evalgraph
		dwg_point_3d *origin_pt
		dwg_point_3d *normal
		double height
		int sides
		double radius
		double topradius

Dwg_Object_ACSH_SPHERE_CLASS *
dwg_add_ACSH_SPHERE_CLASS(evalgraph, origin_pt, normal, radius)
		Dwg_Object_EVALUATION_GRAPH *evalgraph
		dwg_point_3d *origin_pt
		dwg_point_3d *normal
		double radius

Dwg_Object_ACSH_TORUS_CLASS *
dwg_add_ACSH_TORUS_CLASS(evalgraph, origin_pt, normal, major_radius, minor_radius)
		Dwg_Object_EVALUATION_GRAPH *evalgraph
		dwg_point_3d *origin_pt
		dwg_point_3d *normal
		double major_radius
		double minor_radius

Dwg_Object_ACSH_WEDGE_CLASS *
dwg_add_ACSH_WEDGE_CLASS(evalgraph, origin_pt, normal, length, width, height)
		Dwg_Object_EVALUATION_GRAPH *evalgraph
		dwg_point_3d *origin_pt
		dwg_point_3d *normal
		double length
		double width
		double height

Dwg_Object_EVALUATION_GRAPH *
dwg_add_EVALUATION_GRAPH(dwg, has_graph, nodeid, num_evalexpr, evalexpr)
		Dwg_Data *dwg
		int has_graph
		int nodeid
		unsigned num_evalexpr
		BITCODE_H *evalexpr

Dwg_Object_ACSH_HISTORY_CLASS *
dwg_add_ACSH_HISTORY_CLASS(region, h_nodeid)
		Dwg_Entity_3DSOLID *region
		int h_nodeid

Dwg_Entity_3DSOLID *
dwg_add_BOX(blkhdr, origin_pt, normal, length, width, height)
		Dwg_Object_BLOCK_HEADER *blkhdr
		dwg_point_3d *origin_pt
		dwg_point_3d *normal
		double length
		double width
		double height

Dwg_Entity_3DSOLID *
dwg_add_CONE(blkhdr, origin_pt, normal, height, major_radius, minor_radius, x_radius)
		Dwg_Object_BLOCK_HEADER *blkhdr
		dwg_point_3d *origin_pt
		dwg_point_3d *normal
		double height
		double major_radius
		double minor_radius
		double x_radius

Dwg_Entity_3DSOLID *
dwg_add_CYLINDER(blkhdr, origin_pt, normal, height, major_radius, minor_radius, x_radius)
		Dwg_Object_BLOCK_HEADER *blkhdr
		dwg_point_3d *origin_pt
		dwg_point_3d *normal
		double height
		double major_radius
		double minor_radius
		double x_radius

Dwg_Entity_3DSOLID *
dwg_add_EXTRUDED_SOLID(blkhdr, profile, height, taper_angle)
		Dwg_Object_BLOCK_HEADER *blkhdr
		Dwg_Object *profile
		double height
		double taper_angle

Dwg_Entity_3DSOLID *
dwg_add_EXTRUDED_PATH(blkhdr, profile, height, taper_angle)
		Dwg_Object_BLOCK_HEADER *blkhdr
		Dwg_Object *profile
		double height
		double taper_angle

Dwg_Entity_3DSOLID *
dwg_add_PYRAMID(blkhdr, origin_pt, normal, height, sides, radius, topradius)
		Dwg_Object_BLOCK_HEADER *blkhdr
		dwg_point_3d *origin_pt
		dwg_point_3d *normal
		double height
		int sides
		double radius
		double topradius

Dwg_Entity_3DSOLID *
dwg_add_REVOLVED_SOLID(blkhdr, profile, axis_pt, axis_dir, angle)
		Dwg_Object_BLOCK_HEADER *blkhdr
		Dwg_Object *profile
		dwg_point_3d *axis_pt
		dwg_point_3d *axis_dir
		double angle

Dwg_Entity_3DSOLID *
dwg_add_SPHERE(blkhdr, origin_pt, normal, radius)
		Dwg_Object_BLOCK_HEADER *blkhdr
		dwg_point_3d *origin_pt
		dwg_point_3d *normal
		double radius

Dwg_Entity_3DSOLID *
dwg_add_TORUS(blkhdr, origin_pt, normal, torus_radius, tube_radius)
		Dwg_Object_BLOCK_HEADER *blkhdr
		dwg_point_3d *origin_pt
		dwg_point_3d *normal
		double torus_radius
		double tube_radius

Dwg_Entity_3DSOLID *
dwg_add_WEDGE(blkhdr, origin_pt, normal, length, width, height)
		Dwg_Object_BLOCK_HEADER *blkhdr
		dwg_point_3d *origin_pt
		dwg_point_3d *normal
		double length
		double width
		double height

Dwg_Object_BLOCK_CONTROL *
dwg_add_BLOCK_CONTROL(dwg, ms, ps)
		Dwg_Data *dwg
		int ms
		int ps

Dwg_Object_BLOCK_HEADER *
dwg_add_BLOCK_HEADER(dwg, name)
		Dwg_Data *dwg
		char *name

Dwg_Object_UCS *
dwg_add_UCS(dwg, origin, x_axis, y_axis, name)
		Dwg_Data *dwg
		dwg_point_3d *origin
		dwg_point_3d *x_axis
		dwg_point_3d *y_axis
		char *name

Dwg_Object_LAYER *
dwg_add_LAYER(dwg, name)
		Dwg_Data *dwg
		char *name

Dwg_Object_STYLE *
dwg_add_STYLE(dwg, name)
		Dwg_Data *dwg
		char *name

Dwg_Object_LTYPE *
dwg_add_LTYPE(dwg, name)
		Dwg_Data *dwg
		char *name

Dwg_Object_VIEW *
dwg_add_VIEW(dwg, name)
		Dwg_Data *dwg
		char *name

Dwg_Object_DIMSTYLE *
dwg_add_DIMSTYLE(dwg, name)
		Dwg_Data *dwg
		char *name

Dwg_Object_VPORT *
dwg_add_VPORT(dwg, name)
		Dwg_Data *dwg
		char *name

Dwg_Object_VX_TABLE_RECORD *
dwg_add_VX(dwg, name)
		Dwg_Data *dwg
		char *name

Dwg_Object_APPID *
dwg_add_APPID(dwg, name)
		Dwg_Data *dwg
		char *name

Dwg_Object_GROUP *
dwg_add_GROUP(dwg, name)
		Dwg_Data *dwg
		char *name

Dwg_Object_MLINESTYLE *
dwg_add_MLINESTYLE(dwg, name)
		Dwg_Data *dwg
		char *name

Dwg_Object_PROXY_OBJECT *
dwg_add_PROXY_OBJECT(dwg, name, key)
		Dwg_Data *dwg
		char *name
		char *key

Dwg_Entity_PROXY_ENTITY *
dwg_add_PROXY_ENTITY(blkhdr)
		Dwg_Object_BLOCK_HEADER *blkhdr

Dwg_Object_LAYERFILTER *
dwg_add_LAYERFILTER(dwg)
		Dwg_Data *dwg

Dwg_Object_LAYER_INDEX *
dwg_add_LAYER_INDEX(dwg)
		Dwg_Data *dwg

Dwg_Object_SPATIAL_FILTER *
dwg_add_SPATIAL_FILTER(insert)
		Dwg_Entity_INSERT *insert

Dwg_Object_SPATIAL_INDEX *
dwg_add_SPATIAL_INDEX(dwg)
		Dwg_Data *dwg

Dwg_Object_WIPEOUTVARIABLES *
dwg_add_WIPEOUTVARIABLES(dwg)
		Dwg_Data *dwg
