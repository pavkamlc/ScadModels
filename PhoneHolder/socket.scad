/*************************************************
 Adjustable Ball & Socket Joint
 Author: Lee J Brumfield
*************************************************/
// Ball diameter
Ball_Socket_size_in_mm= 20;// [5:1:40]
// Length is approximate. Adjust the number to get the length you want
Length_Multiplier=3  ;// [1:1:10]
Width_of_Base= 60;// [20:1:200]
Thickness_of_Base= 3;// [1:1:20]

numSpacing=7; 

/* [Hidden] */
//Nothing to change below here
WB=Width_of_Base;
BS=Ball_Socket_size_in_mm;
TB=Thickness_of_Base;
LM=Length_Multiplier;

$fn=80;

module spacing(count) {
	for(angle=[0:360/count:360]) {
		translate([0,0,12*BS/15+36]) rotate([0,90,angle]) minkowski() {
			cube([40,BS/15,80]);
			cylinder(r=BS/15,h=10,center=true);
			}
	}
}

module plate() {
	difference() {
		union() {
			minkowski() {
				cube([WB-4,WB-4,TB],center=true);
				cylinder(r=2,h=0.001,center=true);
			}
		// center position plus
		translate([0,0,-5]) cylinder(5,2,5);
		}
	// center minus
	translate([0,0,-5/2]) cylinder(5,2,5);
	// top
	translate([20,0,-5]) cylinder(10,2,2);
	// bottom
	translate([-20,0,-5]) cylinder(10,2,2);
	}
}

module Stem() {
	difference() {
		union() {
			intersection() {
				translate([0,0,BS/2+(BS*2)/10]) linear_extrude(height=BS,center=true,convexity=10,twist=-720)
				translate([(BS*2)/10,0,0]) circle(r=BS+BS/3); 
				translate([0,0,(BS*2)/10+BS/2]) cylinder(r=BS+(BS*2)/6,h=BS,center=true); 
			}
			translate([0,0,(BS*2)/10+BS/2]) cylinder(r=BS+(BS*2)/10,h=BS,center=true); 
			translate([0,0,BS+(BS*2)/10]) sphere(r=BS+(BS*2)/10);
			translate([0,0,-(BS*LM)/4-5]) cylinder(r=(BS+(BS*2)/10)/2,h=(BS*LM)/2+5,center=true);
			hull() {
				translate([0,0,-BS/2-(BS+(BS*2)/10)/2+(BS+(BS*2)/10)/2]) cylinder(r=(BS+(BS*2)/10)/2, h=.1,center=true);
				translate([0,0,BS+(BS*2)/10]) cylinder(r=BS+(BS*2)/10,h=.1,center=true);
			}
			
			translate([0,0,-BS*LM/2-9]) rotate([180,0,0]) plate();
	}
	translate([0,0,BS+(BS*2)/10]) sphere(r=BS);
	translate([0,0,(BS+(BS*2)/10)+(BS+(BS*2)/10)/3+21]) cube([80,80,40],center=true);
	
	spacing(numSpacing);
	
	translate([0,0,2*BS]) sphere(r=BS);
	}
}

module Nut() {
	difference() {
	union() {
		translate([0,0,BS/2+BS/4]) cylinder(r=BS*1.75, h=BS*14/10, $fn=8,center=true);
		}
	intersection() {
		translate([0,0,BS/5+BS/2+BS/4]) linear_extrude(height = BS+.01,center=true,convexity=10,twist=-720)
		translate([BS/5,0,BS/4]) scale(1.1) circle(r = BS+BS/3); 
		translate([0,0,BS/5+3*BS/4]) scale(1.1) cylinder(r=BS+BS/3,h=BS,center=true); 
		}
	cylinder(r=BS,h=2*BS,center=true); 
	translate([0,0,BS/5+BS/4]) sphere(r=BS+BS/5);
	}
}

module Base()  {
	translate([0,0,BS/2]) cylinder(r=BS/2,h=BS,center=true);
	translate([0,0,BS+BS/5+2]) sphere(r=BS);
	translate([0,0,-TB/2-.499]) plate();
}

color ("red") Stem ();
translate([0,-80,0]) color ("green") Nut();
translate([0,80,0]) color ("blue") Base ();