include<Mendel90\scad\vitamins\stepper-motors.scad>;
include<Mendel90\scad\vitamins\ball-bearings.scad>;
include<involute_gears.scad>;

translate([0, 0, -50])NEMA(NEMA17);

translate([0, 0, -30])ball_bearing(BB608);

$fn = $preview?20:80;

/* [Sizes] */
//master box size
exwidth = 42;
//thin of base
exthin = 5;

difference(){
  translate([-exwidth / 2, -exwidth / 2, 0])cube([exwidth, exwidth, exthin]);
  translate([0, 0, 0])cylinder(exthin, 12, 12);
}

gear(17,8);

module HelixGear (
	teeth=17,
	circles=8)
{
	//double helical gear
	{
		twist=200;
		height=20;
		pressure_angle=30;

		gear (number_of_teeth=teeth,
			circular_pitch=700,
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
			circular_pitch=700,
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