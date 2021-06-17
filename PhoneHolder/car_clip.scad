include <base.scad>
$fn=100;
clip_angle=0;
length=25;
width=25;
thin=2.5;
thick=5;
plate=45;
rounded=2;

module Lclip() {
		translate([0,1.5,0]) rotate([0,0,-2.1]) cube([length,thin,width]);
		translate([length-2,0.1,0]) rotate([0,0,15]) cube([5,thin,width]);
} 

module clips() {
	Lclip();
	translate([0,0,width]) rotate([180,0,0]) Lclip();
}

module car_clip() {
	difference() {
		union() {
			clips();
			rotate([0,0,clip_angle]) translate([-thick,-plate/2,0]) 
				rcube([thick,plate,width],[2,2,2,2]);
			}
		translate([-thick, 15, width/2]) sphere(4); // top point
		translate([-thick, -15, width/2]) sphere(4); // bottom point
		translate([-thick*2,0,12.5]) rotate([0,90,0]) cylinder(r=0.5,h=thick*3,$fn=50); // central point
	}
}

car_clip();