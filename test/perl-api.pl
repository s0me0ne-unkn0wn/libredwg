#!/usr/bin/perl

use LibreDWG;

#my $dwg = LibreDWG::API::_dwg_new();
#LibreDWG::API::dwg_read_file('empty.dwg', $dwg);
# my $dwg = LibreDWG::API::dwg_add_Document(24, 0, 9);
# warn '---------------------------------------------------------- ADDED ----------------------------------------------------------';
# my $hdr = LibreDWG::API::_dwg_get_Object_BLOCK_HEADER($dwg);
# warn '---------------------------------------------------------- GOT BLOCK HEADER ----------------------------------------------------------';
# LibreDWG::API::dwg_add_LINE($hdr, [0, 0, 0], [0, 10, 0]);
# LibreDWG::API::dwg_add_LINE($hdr, [0, 0, 0], [10, 0, 0]);
# LibreDWG::API::dwg_add_LINE($hdr, [0, 10, 0], [10, 10, 0]);
# LibreDWG::API::dwg_add_LINE($hdr, [10, 0, 0], [10, 10, 0]);
# warn '---------------------------------------------------------- LINE ADDED ----------------------------------------------------------';
# LibreDWG::API::dwg_write_file('./test1.dwg', $dwg);
# warn '---------------------------------------------------------- WRITTEN ----------------------------------------------------------';

my $dwg = LibreDWG->new;#('empty.dwg');
# $dwg->add_LINE([0, 0, 0], [10, 10, 0]);
# $dwg->add_POLYLINE_2D([[0, 0], [0, 10], [10, 10], [10, 20]]);
# $dwg->add_TEXT("text", [0, 0, 0], 3);
# $dwg->add_ARC([5, 15, 0], 5, 0, 90);
# $dwg->add_DIMENSION_ALIGNED([0, 0, 0], [0, 10, 0], [-5, 5, 0]);
# # $dwg->add_DIMENSION_ANG2LN([10, 0, 0], [0, 0, 0], [10, 10, 0], [8, 5, 0]);
# $dwg->add_DIMENSION_ANG3PT([10, 0, 0], [0, 0, 0], [10, 10, 0], [8, 5, 0]);
# $dwg->add_DIMENSION_DIAMETER([0, 0, 0], [10, 10, 0], 2);
$dwg->add_DIMENSION_ORDINATE([10, 10, 0], [10, 10, 0], 1);
$dwg->add_DIMENSION_RADIUS([5, 5, 0], [5, 10, 0], 2);
$dwg->write_file('test2.dwg');
