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
# $dwg->add_LINE([0, 0, 0], [0, 10, 0]);
# $dwg->add_LINE([0, 0, 0], [10, 0, 0]);
# $dwg->add_LINE([0, 10, 0], [10, 10, 0]);
# $dwg->add_LINE([10, 0, 0], [10, 10, 0]);
$dwg->add_POLYLINE_2D([[0,0],[0,10],[10,10],[10,20]]);
$dwg->write_file('test2.dwg');
