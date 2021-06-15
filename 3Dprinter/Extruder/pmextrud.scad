include<NopSCADlib/utils/core/core.scad>;
include<NopSCADlib/vitamins/e3d.scad>;
include<NopSCADlib/vitamins/spring.scad>;

include<MCAD/bearing.scad>;

include<BOSL/involute_gears.scad>;
include<BOSL/metric_screws.scad>
include<BOSL/nema_steppers.scad>;

use<extrude_gear.scad>;

    //bearing(, center=true);


$fn = $preview?20:80;

/* [Sizes] */
//extruder thin
ex_thin = 42;
//master box size
motor_size = 42;
//thin of base
exthin = 8;
//extruder gear length
exlength = 14;
//fillament
fillament=1.75;

// extruder box
color("green") difference() {
    union() {

	    // motor plate
	    difference() {
  		    translate([-motor_size / 2, -motor_size / 2, 0]) rcube([motor_size, motor_size, exthin],[0,5,5,0]);
  		    translate([0, 0, 0]) cylinder(exthin, 12, 12);
	    }

        //base plate for A8
        translate([0,21+8,0]) rotate([180,0,0]) import("A8-0004.stl");

        // mount plate for another
        //translate([-motor_size / 2, +motor_size / 2 + exthin, 0]) rotate([90,0,0]) rcube([motor_size,motor_size,exthin],[0,0,5,5]);

        //bottom
        translate([-motor_size / 2 - 20, -motor_size / 2 - 35, 0]) rcube([motor_size, motor_size, exthin],[5,5,0,14]);
        //top
        translate([-motor_size / 2 - 20, -motor_size / 2 - 35, ex_thin-exthin]) rcube([motor_size, motor_size, exthin],[5,5,0,14]);

        // out fillament
        linear_extrude(height=ex_thin) 
        translate([1,-38,0]) polygon(points=[[0,0],[0,10],[-20,1],[-20,-1],[0,-10]]);

        // in fillament
        linear_extrude(height=ex_thin) 
            translate([-motor_size + 1,-38,0]) polygon(points=[[0,0],[0,-10],[+20,-1],[20,1],[0,10]]);

        }

    // bearings
    translate([-20, -35, -1]) bearing(model=608, outline=true);
    translate([-20, -35, ex_thin - bearingWidth(model=608) + 1]) bearing(model=608, outline=true);

    // motor
    translate([0, 0, exthin])rotate([0,180,0])nema17_stepper();

    //filament path
    translate([-50, -38, 24]) rotate([0,90,0]) cylinder(100, fillament/2,fillament/2);

	//smallscrew
	translate([-5,-52,0]) rotate([180,0,0]) metric_bolt(headtype="hex", size=2.5, shank=ex_thin+3, l=ex_thin+3);
    
    // bowden hole
    translate([0.9, -38, 24]) rotate([0,90,0]) metric_bolt(headtype="hex", size=6, l=8);

    // axe
    translate([-20,-35,-5]) rotate([0,0,0]) cylinder(50,2.5,2.5);

    screw_variets();
}

module screw_variets() {
    //spring screw down
    translate([-37,-105,exthin + 3]) rotate([90,0,0]) metric_bolt(headtype="hex", size=2.5, shank=80, l=80);
    translate([-37-3,-105,exthin + 3]) rotate([90,0,-2]) metric_bolt(headtype="hex", size=2.5, shank=80, l=80);
    translate([-37-6,-105,exthin + 3]) rotate([90,0,-5]) metric_bolt(headtype="hex", size=2.5, shank=80, l=80);
    translate([-37-9,-105,exthin + 3]) rotate([90,0,-7]) metric_bolt(headtype="hex", size=2.5, shank=80, l=80);
    //sprint screw up
    translate([-37,-105, ex_thin - exthin - 3]) rotate([90,0,0]) metric_bolt(headtype="hex", size=2.5, shank=80, l=80);
    translate([-37-3,-105, ex_thin - exthin - 3]) rotate([90,0,-2]) metric_bolt(headtype="hex", size=2.5, shank=80, l=80);
    translate([-37-6,-105, ex_thin - exthin - 3]) rotate([90,0,-5]) metric_bolt(headtype="hex", size=2.5, shank=80, l=80);
    translate([-37-9,-105, ex_thin - exthin - 3]) rotate([90,0,-7]) metric_bolt(headtype="hex", size=2.5, shank=80, l=80);
}

//spring screw down
translate([-37,-105, exthin + 3]) rotate([90,0,0]) color("lightblue") metric_bolt(headtype="hex", size=2.5, shank=80, l=80);
//sprint screw up
translate([-37,-105, ex_thin - exthin - 3]) rotate([90,0,0]) color("lightblue") metric_bolt(headtype="hex", size=2.5, shank=80, l=80);

// bowden connector
translate([0, -38, 24]) rotate([0,90,0]) bowden_connector();

//lever
color("darkgreen") difference() {
        union() {
            translate([-exlength/2 - exthin - 5, -57, exthin + 0.5])
                linear_extrude(height=ex_thin - exthin - exthin - 0.5 - 0.5) 
                    polygon(points=[[0,0],[21,0],[21,8],[3,16],[-3,16],[-21,8],[-21,0]]);
        }
        //hole
        translate([-20, -45, 8]) cylinder(20,1.5,1.5);
        //bearing
        translate([-20, -45, (exlength+4.5)/2+(exthin)/2+0.5]) bearing(model=608,outline=true);
        //smallscrew
	    translate([-5,-52,0]) rotate([180,0,0]) metric_bolt(headtype="hex", size=2.5, shank=40, l=40);
        screw_variets();
    }
    //color("yellow") translate([-20, -45, (exlength+4.5)/2+(exthin)/2+0.5]) bearing(model=608);
    color("yellow") translate([-20, -43, 11.5]) extruder_gear("BMG");

// extruder gear
color("grey") translate([-20,-35,11.5]) extruder_gear("BMG", false);

// bearings
color("orange") translate([-20, -35, -1]) bearing(model=608);
color("orange") translate([-20, -35, ex_thin - bearingWidth(model=608) + 1]) bearing(model=608);

// motor
//translate([0, 0, exthin] )rotate([0,180,0]) nema17_stepper();

//filament path
color("red") translate([-50, -38, 24]) rotate([0,90,0]) cylinder(100, fillament/2,fillament/2);

//smallscrew
*translate([-5,-52,0]) rotate([180,0,0]) metric_bolt(headtype="hex", size=2.5, l=ex_thin+3);

// gears
*color("blue") translate([0,0,-5]) helix_gear(17,8,200);
*color("lightblue") translate([-20,-35,-5]) helix_gear(67,8,-200);

// axe
*translate([-20,-35,-5]) rotate([0,180,0]) metric_bolt(headtype="hex", size=5, shank=35, l=45);

// distantion
translate([50,0,0]) {
    difference() {
        union() {
            cylinder(1,5,5);
            cylinder(7,3,3);
        }
        cylinder(7,1.5,1.5);
    }
}

module helix_gear(teeth=17, parheight=8, partwist=200) {
	//double helical gear
	{
		twist=partwist;
		height=parheight;
		pressure_angle=30;

		gear(mm_per_tooth = 3,
            number_of_teeth=teeth,
			pressure_angle=pressure_angle,
			thickness = height/2,
            hole_diameter = 3,
            twist=twist/teeth,
            align=V_UP
			);
		mirror([0,0,1]) gear(mm_per_tooth = 3,
            number_of_teeth=teeth,
			pressure_angle=pressure_angle,
			thickness = height/2,
            hole_diameter = 3,
            twist=twist/teeth,
            align=V_UP
			);
	}
}

module rcube(size, radius) {
    hull() {
        // BL
        if(radius[0] == 0) cube([1, 1, size[2]]);
        else translate([radius[0], radius[0]]) cylinder(r = radius[0], h = size[2]);
        // BR
        if(radius[1] == 0) translate([size[0] - 1, 0]) cube([1, 1, size[2]]);
        else translate([size[0] - radius[1], radius[1]]) cylinder(r = radius[1], h = size[2]);
        // TR
        if(radius[2] == 0) translate([size[0] - 1, size[1] - 1])cube([1, 1, size[2]]);
        else translate([size[0] - radius[2], size[1] - radius[2]]) cylinder(r = radius[2], h = size[2]);
        // TL
        if(radius[3] == 0) translate([0, size[1] - 1]) cube([1, 1, size[2]]);
        else translate([radius[3], size[1] - radius[3]]) cylinder(r = radius[3], h = size[2]);
    }
}

module exspring() {
    if($preview) 
        comp_spring(["extruder_spring", 6, 1.5, 30, 10,  1, false, 6, "silver"]);
    else 
        comp_spring(["extruder_spring", 6, 1.5, 30, 10,  1, true, 6, "silver"]);
}

// springs
translate([-37,-57 - 17.5,11]) rotate([90,0,0]) exspring();
translate([-37,-57 - 17.5,31]) rotate([90,0,0]) exspring();

//ejector
color("lightgreen") {
    translate([-46, -62, 0])
        linear_extrude(height=ex_thin) 
            polygon(points=[[0,0],[30,0],[30,4],[4,4],[4,6],[0,6]]);
    translate([-26, -62, ex_thin/2 - 15/2])
        rotate([0,0,-10]) cube([30,4,15]);
}