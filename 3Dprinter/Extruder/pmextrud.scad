include<Mendel90/scad/vitamins/stepper-motors.scad>;
include<Mendel90/scad/vitamins/ball-bearings.scad>;
include<involute_gears.scad>;

$fn = $preview?20:80;

/* [Sizes] */
//master box size
exwidth = 42;
//thin of base
exthin = 8;
//extruder gear length
exlength = 14;

#translate([0, 0, exthin])rotate([0,180,0])NEMA(NEMA17);

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
        translate([-exwidth / 2 - 20, -exwidth / 2 - 35 , 0]) cube([exthin, exwidth, exlength + exthin + 8]);
        translate([exwidth / 2 - 20 - exthin, -exwidth / 2 - 35 , 0]) cube([exthin, exwidth, exlength + exthin + 8]);
    }
    translate([-20, -35, exthin + 3]) ball_bearing(BB608);
    translate([-20, -35, exlength + exthin + 5]) ball_bearing(BB608);
}

    translate([-20, -35, exthin - 1]) ball_bearing(BB608);
    translate([-20, -35, exlength + exthin + exthin - 1 - 1]) ball_bearing(BB608);


// gears
#translate([0,0,-5]) HelixGear(23,0,8,150);
#translate([-20,-35,-5]) HelixGear(72,10,8,150);

module HelixGear ( teeth=17, circles=8, parheight=8, pardimension=170) {
	//double helical gear
	{
		twist=200;
		height=parheight;
		pressure_angle=30;

		gear (number_of_teeth=teeth,
			circular_pitch=pardimension,
			pressure_angle=pressure_angle,
			clearance = 0.2,
			gear_thickness = height/2*0.5,
			rim_thickness = height/2,
			rim_width = 5,
			hub_thickness = height/2*1.2,
			hub_diameter=15,
			bore_diameter=5,
			circles=circles,
			twist=twist/teeth);
		mirror([0,0,1])
		gear (number_of_teeth=teeth,
			circular_pitch=pardimension,
			pressure_angle=pressure_angle,
			clearance = 0.2,
			gear_thickness = height/2,
			rim_thickness = height/2,
			rim_width = 5,
			hub_thickness = height/2,
			hub_diameter=15,
			bore_diameter=5,
			circles=circles,
			twist=twist/teeth);
	}
}