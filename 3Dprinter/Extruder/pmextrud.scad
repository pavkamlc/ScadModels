include<NopSCADlib/utils/core/core.scad>;

include<MCAD/bearing.scad>;

include<BOSL/involute_gears.scad>;
include<BOSL/metric_screws.scad>
include<BOSL/nema_steppers.scad>;

$fn = $preview?20:80;

/* [Sizes] */
//master box size
exwidth = 42;
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
  		translate([-exwidth / 2, -exwidth / 2, 0]) rcube([exwidth, exwidth, exthin],[0,21,0,0]);
  		translate([0, 0, 0])cylinder(exthin, 12, 12);
	}

    // anet a8 bowden mount plate
    translate([-exwidth / 2, +exwidth / 2 + exthin, 0]) rotate([90,0,0]) rcube([exwidth,exwidth,exthin],[0,0,5,5]);

    //bottom
    translate([-exwidth / 2 - 20, -exwidth / 2 - 35, 0]) rcube([exwidth, exwidth, exthin],[5,5,0,14]);
    //top
    *translate([-exwidth / 2 - 20, -exwidth / 2 - 35, 27]) rcube([exwidth, exwidth, exthin],[5,5,0,14]);

    // out fillament
    linear_extrude(height=exlength + exthin + exthin) 
        translate([1,-38,0]) polygon(points=[[0,0],[0,10],[-20,1],[-20,-1],[0,-10]]);

    // in fillament
    linear_extrude(height=exlength + exthin + exthin) 
        translate([-exwidth + 1,-38,0]) polygon(points=[[0,0],[0,-10],[+20,-1],[20,1],[0,10]]);
    }

    // bearings
    translate([-20, -35, -1]) bearing(model=608, outline=true);
    translate([-20, -35, exlength + exthin + exthin - 1]) bearing(model=608, outline=true);

    // motor
    translate([0, 0, exthin])rotate([0,180,0])nema17_stepper();

    //filament path
    translate([-50, -38, exlength/2 + exthin + 2]) rotate([0,90,0]) cylinder(100, fillament/2,fillament/2);

	//smallscrew
	translate([-5,-82,0]) rotate([180,0,0]) metric_bolt(headtype="hex", size=2.5, shank=40, l=40);
}

//spring screw down
translate([-37,-105,11]) rotate([90,0,0]) metric_bolt(headtype="hex", size=2.5, shank=80, l=80);
translate([-37-3,-105,11]) rotate([90,0,-2]) metric_bolt(headtype="hex", size=2.5, shank=80, l=80);
translate([-37-6,-105,11]) rotate([90,0,-4]) metric_bolt(headtype="hex", size=2.5, shank=80, l=80);
translate([-37-9,-105,11]) rotate([90,0,-6]) metric_bolt(headtype="hex", size=2.5, shank=80, l=80);
//sprint screw up
translate([-37,-105,24.5]) rotate([90,0,0]) metric_bolt(headtype="hex", size=2.5, shank=80, l=80);
translate([-37-3,-105,24.5]) rotate([90,0,-2]) metric_bolt(headtype="hex", size=2.5, shank=80, l=80);
translate([-37-6,-105,24.5]) rotate([90,0,-4]) metric_bolt(headtype="hex", size=2.5, shank=80, l=80);
translate([-37-9,-105,24.5]) rotate([90,0,-6]) metric_bolt(headtype="hex", size=2.5, shank=80, l=80);


//lever
color("pink") difference() {
        union() {
            translate([-exlength/2-exthin-5,-57,exthin+0.5])
                linear_extrude(height=exlength + 4.5) 
                    polygon(points=[[0,0],[21,0],[21,8],[3,16],[-3,16],[-21,8],[-21,0]]);
        }
        //hole
        #translate([-20, -45, 8]) cylinder(20,4,4);
        //bearing
        translate([-20, -45, (exlength+4.5)/2+(exthin)/2+0.5]) bearing(model=608,outline=true);
        //smallscrew
	    translate([-5,-52,0]) rotate([180,0,0]) metric_bolt(headtype="hex", size=2.5, shank=40, l=40);
    }
    color("yellow") translate([-20, -45, (exlength+4.5)/2+(exthin)/2+0.5]) bearing(model=608);

// bearings
color("orange") translate([-20, -35, -1]) bearing(model=608);
color("orange") translate([-20, -35, exlength + exthin + exthin - 1]) bearing(model=608);

// motor
*translate([0, 0, exthin])rotate([0,180,0])nema17_stepper();

//filament path
color("red") translate([-50, -38, exlength/2 + exthin + 2]) rotate([0,90,0]) cylinder(100, fillament/2,fillament/2);

//smallscrew
*%translate([-5,-52,0]) rotate([180,0,0]) metric_bolt(headtype="hex", size=2.5, l=40);

// gears
*color("blue") translate([0,0,-5]) helix_gear(17,8,200);
*color("lightblue") translate([-20,-35,-5]) helix_gear(67,8,-200);

// axe
*translate([-20,-35,-5]) rotate([0,180,0]) metric_bolt(headtype="hex", size=5, shank=35, l=45);

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
