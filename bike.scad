// diameter of the handlebar
tubeDiameter = 31;
// width of the mounting ring
width = 25;
// in case of using zip ties, their width
cableTiesWidth = 3;

/* [hidden] */
// plate thickness 1
th = 2;
// plate thickness 2
bt = 4;
$fn = 150;
thick = 5;

translate([-max(width, (width * 3) / 2) - 0.5, 0, 0])
  BikeMountUpper();
translate([0.5, 0, 0])BikeMountLower();

module BikeMountUpper(){
  difference(){
    MountBase();
    translate([width / 2, -tubeDiameter / 2 - 6, -0.01])Screw(4.3, 20, 3, 6);
    translate([width / 2, tubeDiameter / 2 + 6, -0.01])Screw(4.3, 20, 3, 6);
  }
  difference(){
    translate([width / 2, 0, tubeDiameter / 2 + 2 + (th + bt) / 2])cubeR([23, 44, th + bt], 2, true);
    translate([width / 2, 15, width / 2 + 8])sphere(4);// top point// top point
    translate([width / 2, -15, width / 2 + 8])sphere(4);// bottom point// bottom point
    translate([width / 2, 0, 10])rotate([0, 0, 0])cylinder(r = 1, h = thick * 3, $fn = 50);// central point
  }

}

module BikeMountLower(){
  difference(){
    MountBase();
    translate([width / 2, -tubeDiameter / 2 - 6, -0.01])Screw(4.3, 20, 3);
    translate([width / 2, tubeDiameter / 2 + 6, -0.01])Screw(4.3, 20, 3);
  }
}

// a half ring and side wings for the screws
module MountBase(){
  difference(){
    rotate([0, 90, 0])emptyWheel(tubeDiameter / 2 + 3 + 3, width, 3);
    translate([0, -tubeDiameter / 2 - 3 - 3 - 0.01, -tubeDiameter / 2 - 3 - 3 - 0.01])
      cube([width, tubeDiameter + 4 * 3 + 0.02, tubeDiameter / 2 + 3 + 3 + 0.01]);
  }

  difference(){
    hull(){
      translate([width / 2, -tubeDiameter / 2 - 6, 0])buttonRound(width / 2, 6, 2);
      translate([width / 2, tubeDiameter / 2 + 6, 0])buttonRound(width / 2, 6, 2);
    }
    translate([-0.01, 0, 0])rotate([0, 90, 0])cylinder(r = tubeDiameter / 2 + 3, h = width + 0.02);
  }
}

// cube with rounded corners
module cubeR(dims, rnd = 1, centerR = false){
  translate(centerR?[-dims[0] / 2, -dims[1] / 2, -dims[2] / 2]:[])
    minkowski(){
      cube([dims[0], dims[1], dims[2]], center = false);
      cylinder(0.001, rnd);
    }
}

// rounded button - lower part is a cylinder, upper part like a filled ring
// r= outer radius
// h= height
// rr= upper rounding
// buttonRound(20,10,2);
module buttonRound(r, h, rr){
  hull(){
    translate([0, 0, h - rr])translate([0, 0, rr])rotate_extrude(convexity = 2)translate([r - rr, 0, 0])circle(r = rr);
    cylinder(r = r, h = h - rr);
  }
}

// emptyWheel(20,10,2);
module emptyWheel(wr, h, rr){
  translate([0, 0, rr])rotate_extrude(convexity = 2)translate([wr - rr, 0, 0])circle(r = rr);
  translate([0, 0, rr])difference(){
      cylinder(r = wr, h = h - 2 * rr);
      translate([0, 0, -0.01])cylinder(r = wr - 2 * rr, h = h);
    }
  translate([0, 0, h - rr])rotate_extrude(convexity = 2)translate([wr - rr, 0, 0])circle(r = rr);
}

// simple screw model
// Screw(4, 10, 7, 6);
module Screw(m, h, th, fn = 50){
  cylinder(r = m / 2, h = h);
  translate([0, 0, th])cylinder(r = m, h = h - th, $fn = fn);
}

// ring space to fix zip ties
// translate([-20,0,0]) ring();
module ring(){
  rotate([0, 90, 0])
    difference(){
      cylinder(r = tubeDiameter / 2 + 3 + 3.01, h = cableTiesWidth);
      translate([0, 0, -0.01])
        cylinder(r = tubeDiameter / 2 + 1 + 3.01, h = cableTiesWidth + 0.02);
    }
}