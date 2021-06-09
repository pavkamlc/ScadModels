include <Mendel90\scad\vitamins\stepper-motors.scad>;

$fs=150;

//translate([0,0,-1]) NEMA(NEMA17);

exwidth=42;
exthin=5; //thin of base

difference(){
    translate([-exwidth/2,-exwidth/2,0]) cube([exwidth,exwidth,exthin]);
    cylinder([5,5,5]);
}
