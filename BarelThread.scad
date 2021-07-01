include<NopSCADlib/utils/core/core.scad>;
use <NopSCADlib/utils/thread.scad>

pitch = 6;
starts = 1;

profile = thread_profile(pitch / 2, 1.2, 60, 2.25);
translate([0,0,30/2]) thread(90, pitch, 30, profile, starts = starts, top = 0, bot = 20, female = true);

cylinder(5,45,45);


for (angle=[0:360/8:360]) {
    handle_diameter = 90 + 10;
    translate([handle_diameter/2*sin(angle),handle_diameter/2*cos(angle),0]) cylinder(30,3,3);
}

