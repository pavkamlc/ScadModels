include<BOSL/involute_gears.scad>;
use <NopSCADlib/vitamins/o_ring.scad>

$fn = $preview?20:100;

E=0.01;

translate([0,0,0]) extruder_gear("BMG");
translate([0,0,0]) extruder_hole("BMG");
//translate([30,0,0]) extruder_gear("BMG", false);
//translate([60,0,0]) extruder_gear("MK8");

module extruder_hole(type="MK8") {
    cylinder(6,5.5,5.5);
    cylinder(15,4.5,4.5);
}

module extruder_gear(type="MK8", screw = true) {

    screwpos = (type == "MK8") ? 2.5 : 8;

    difference() {

        // body tube
        union() { 
            if(type == "MK8") {
                cylinder(d=12,h=5);
                cylinder(d=8,h=13); 
            }

            if(type == "BMG") {
                translate([0,0,3]) gear(1.60,18,6);
                cylinder(d=8,h=15); 
            }
        }   
  
        // teeths
        if(type == "MK8") {
            translate([0,0,9]) extruder_teeths(30,4,0.3,2.9); // washer
            translate([0,0,-E]) cylinder(d=5,h=13+2*E); //axe hole
        }

        if(type == "BMG") {
            translate([0,0,12.5]) extruder_teeths(50,1.5,0.1,3.6); // washer
            translate([0,0,-E]) cylinder(d=5,h=19+2*E); //axe hole
        }

        //screw hole
        if(screw)
            translate([0,0,screwpos])
                rotate([90,0,0])
                    cylinder(d=3,h=6+E);
    }

    // mount screw
    if(screw) {
        if(type == "MK8") 
            translate([0,-2.5,screwpos]) mount_screw();
        if(type == "BMG") 
            translate([0,-1.5,screwpos]) mount_screw();
    }
}

// mount screw
module mount_screw() {
    rotate([90,0,0]) 
            difference() {
                cylinder(d=3,h=3);
                translate([0,0,2]) cylinder(d=2,h=1+E,$fn=6);
            }
}
// milling teeths
module extruder_teeths(tooths=30, milling_r=5, depth_milling_teeth = 1, milling_offset = 3) {
    tooth_angle = 360 / tooths;
    milling_low_r = milling_r - depth_milling_teeth;

    if($preview) 
        O_ring(12-milling_offset, milling_low_r * 2);
    else 
        for(i=[0:tooths]) {
        hull() {
            rotate([0,0,tooth_angle*i]) translate([milling_r+milling_offset,0,0]) rotate([90,0,0]) cylinder(r=milling_r,h=0.01);
            rotate([0,0,tooth_angle*i+tooth_angle/2]) translate([milling_r+milling_offset,0,0]) rotate([90,0,0]) cylinder(r=milling_low_r,h=0.01);
        }
        hull() {
            rotate([0,0,tooth_angle*i+tooth_angle/2]) translate([milling_r+milling_offset,0,0]) rotate([90,0,0]) cylinder(r=milling_low_r,h=0.01);
            rotate([0,0,tooth_angle*(i+1)]) translate([milling_r+milling_offset,0,0]) rotate([90,0,0]) cylinder(r=milling_r,h=0.01);
        }
    }
}
