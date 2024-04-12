/*
Star Trek Com Badge Coat Hooks

Copyright 2024 nomike[AT]nomike[DOT]com

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS “AS IS” AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

include <screw_holes.scad>;

$fn = 255;

oval_height = 7;
oval_radius = 18;
oval_scale_x = 1.3;
oval_scale_y = 1;
oval_brim_height = 1;
oval_brim_width = 1;

starfleet_emblem_svg_x = 105.058;
starfleet_emblem_svg_y = 167.008;
starfleet_width_percentage = 0.6;

_oval_width = oval_radius * 2 * oval_scale_x;
_oval_height = oval_radius * 2 * oval_scale_y;

starfleet_emblem_scale = (_oval_width * starfleet_width_percentage) / starfleet_emblem_svg_x;
_starfleet_emblem_width = starfleet_emblem_svg_x * starfleet_emblem_scale;
_startfleet_emblem_height = starfleet_emblem_svg_y * starfleet_emblem_scale;
starfleet_emblem_offset_x = (_oval_width / 2) - (_starfleet_emblem_width / 2);
starfleet_emblem_offset_y = (_oval_height / 2) - (_startfleet_emblem_height / 2);
starfleet_emblem_height = 9;
starfleet_emblem_brim_height = 1;
starfleet_emblem_brim_scale = 0.9;


hook_width = 15.013;
hook_offset_y = -21;

screw_m = M4;
screw_radius = 3;
screwhead_radius = 8;
screwhead_height = 5;
screw_center_offset_x = 16;
screw_center_offset_y = 0;

dowel_recess = 2;

knob_diameter = 10;
knob_height = 15;

type = "hook"; // "knob" or "hook"


// You should not need to change anything below here

// File: hook.stl
// X size: 15.013
// Y size: 22.512
// Z size: 30.432
// X position: 10.934
// Y position: -0.002
// Z position: 7.5
NE=1; NW=2; SW=3; SE=4; CTR=5;
module hook (where) {
	if (where == NE) {
		objNE ();
	}

	if (where == NW) {
		translate([ -15.013 , 0 , 0 ])
		objNE ();
	}

	if (where == SW) {
		translate([ -15.013 , -22.512 , 0 ])
		objNE ();
	}

	if (where == SE) {
		translate([ 0 , -22.512 , 0 , ])
		objNE ();
	}

	if (where == CTR) {
	translate([ -7.506 , -11.256 , -15.216 ])
		objNE ();
	}
}

module objNE () {
	translate([ -10.934 , 0.002 , -7.5 ])
		import("hook.stl");
}

difference() {
	union() {
		scale([oval_scale_x, oval_scale_y, 1]) translate([oval_radius, oval_radius, 0]) difference() {
			color("green") cylinder(h=oval_height + oval_brim_height, r=oval_radius);
			translate([0, 0, oval_height]) color("purple") cylinder(h=oval_brim_height, r=oval_radius - oval_brim_width);
		}
		translate([starfleet_emblem_offset_x, starfleet_emblem_offset_y, 0]) scale([starfleet_emblem_scale, starfleet_emblem_scale, 1]) union() {
			color("blue") linear_extrude(height=starfleet_emblem_height) import("star_fleet.svg");
		}
		if(type == "hook") {
			translate([(oval_radius * oval_scale_x) - (hook_width / 2), hook_offset_y, 0]) hook(NE);
		}
		if(type == "knob") {
			translate([(oval_radius * oval_scale_x), oval_radius , 0 - knob_height]) difference() {
				color("purple") cylinder(h=knob_height, d=knob_diameter);
				color("red") cylinder(h=knob_height, d=2.9);;

			}
		}
	}
	if(type == "hook") {
		translate([oval_radius * oval_scale_x - screw_center_offset_x, oval_radius * oval_scale_y + screw_center_offset_y, oval_height]) union() {
			rotate([0, 180, 0]) screw_hole(iso=ISO14581, m=screw_m, L=oval_height, b=0);
		}
		translate([oval_radius * oval_scale_x + screw_center_offset_x, oval_radius * oval_scale_y + screw_center_offset_y, oval_height]) union() {
			rotate([0, 180, 0]) screw_hole(iso=ISO14581, m=screw_m, L=oval_height, b=0);
		}
		scale([oval_scale_x, oval_scale_y, 1]) translate([oval_radius, oval_radius, 0]) difference() {
			translate([0, 0, 0]) color("purple") cylinder(h=dowel_recess, r=oval_radius - oval_brim_width);
		}
	}
}


