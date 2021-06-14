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

// motor plate
difference() {
  translate([-exwidth / 2, -exwidth / 2, 0])cube([exwidth, exwidth, exthin]);
  translate([0, 0, 0])cylinder(exthin, 12, 12);
}

// anet a8 bowden mount plate
translate([-exwidth / 2, +exwidth / 2, 0]) cube([exwidth,exthin,exwidth]);

// extruder box
difference() {
    union() {

    translate([-exwidth / 2 - 20, -exwidth / 2 - 35, 0]) cube([exwidth, exwidth, exthin]);
    translate([-exwidth / 2 - 20, -exwidth / 2 - 35, 27]) cube([exwidth, exwidth, exthin]);

    // out fillament
    linear_extrude(height=exlength + exthin + exthin) 
        translate([1,-38,0]) polygon(points=[[0,0],[0,10],[-20,1],[-20,-1],[0,-10]]);

    // in fillament
    linear_extrude(height=exlength + exthin + exthin) 
        translate([-exwidth + 1,-38,0]) polygon(points=[[0,0],[0,-10],[+20,-1],[20,1],[0,10]]);

    }

    // bearings
    translate([-20, -35, -1]) bearing(model=608);
    translate([-20, -35, exlength + exthin + exthin - 1]) bearing(model=608);

    // motor
    translate([0, 0, exthin])rotate([0,180,0])nema17_stepper();

    //filament path
    translate([-50, -38, exlength/2 + exthin + 2]) rotate([0,90,0]) cylinder(100, fillament/2,fillament/2);

}

// gears
#translate([0,0,-5]) HelixGear(17,8,200);
#translate([-20,-35,-5]) HelixGear(67,8,-200);

// axe
translate([-20,-35,-5]) rotate([0,180,0]) metric_bolt(headtype="hex", size=5, shank=35, l=45);

module HelixGear(teeth=17, parheight=8, partwist=200) {
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