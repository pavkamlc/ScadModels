include<NopSCADlib/utils/core/core.scad>;
use <NopSCADlib/utils/thread.scad>

$fn = 80;

// stoupani
pitch = 8;
// pocet zavitu
starts = 1;
// vnejsi prumer
diameter = 100;
// grip size
grip=10;
// grip num
grips = 8;
// height
h = 30;
// thin of desk
thin = 3;

profile = thread_profile(pitch / 2, 1.2, 60, 2.25);
translate([0,0,h/2]) thread(diameter, pitch, h, profile, starts = starts, top = 20, bot = 20, solid = true, female = true);

cylinder(thin,diameter/2,diameter/2);

for (angle=[0:360/grips:360]) {
    handle_diameter = diameter + grip;
    translate([handle_diameter/2*sin(angle),handle_diameter/2*cos(angle),0]) cylinder(h,grip/2,grip/2);
}

