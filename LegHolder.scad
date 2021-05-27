/* [Printing parameters] */
//vertex resolution
$fn=200;//[50:1000]

//printing tolerance
tolerance=0.01;

/* [Sizes] */
// inner diameter
in_d=30; //[10:100]
//thin of ring
thin=2; //[1:5]
//heigh of ring
height=10;
//width hole for pluggin
diff=2;
//thicknes of hole for plugging
hole=2;
//width of hole between cube and ring
dist=4;

module ring(in, out, height) {
    difference() {
        cylinder(height,out/2,out/2);
        translate([0,0,-tolerance]) cylinder(height+tolerance+tolerance,in/2,in/2);
    }
}

union() {
    difference() {
        ring(in_d,in_d+thin+thin,height);
        translate([0,-20/2,-tolerance]) cube([20,20,20]);
        }  
    translate([-in_d/2-thin-diff-4,-8/2,height/2-hole/2]) cube([hole+1,8,hole]);
    translate([-in_d/2-thin-diff-hole-4,-8/2,0]) cube([hole,8,height]);
    translate([-in_d/2-thin-4+1,-8/2,0]) cube([dist,8,height]);
    }