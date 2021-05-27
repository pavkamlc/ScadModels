$fn=40;

// length of arms
$len=100;
$clearance=0.15;

module arm()
{
rotate_extrude(angle=180, convexity=10)
   translate([0, 0]) square(size=[4,8]);

translate([-4,-$len,0]) cube([8,$len,8]);

translate([0,-$len,0])
rotate_extrude(angle=-180, convexity=10)
   translate([0, 0]) square(size=[4,8]);
};

// basic
translate([20,0,0]) arm();

// base+camera
translate([40,0,0]) union() { 
    difference() {
        arm();
        translate([0,-$len,-5]) cylinder(50,2,2); // hole1
    }
    #cylinder(15+8,3-$clearance,3-$clearance); //camera stick
    translate([0,-$len+14,0]) rotate([90]) cylinder(5,1,1); // base fix
    };

//base+arm
translate([60,0,0]) union() { 
    difference() {
        arm();
        translate([0,-$len,-5]) cylinder(50,2,2); // hole1
        translate([0,0,-5]) cylinder(50,2,2); //hole2
    }
    translate([0,-$len+14,0]) rotate([90]) cylinder(5,1,1); // base fix
    };    
    
// arm+camera
translate([80,0,0]) union() { 
    difference() {
        arm();
        translate([0,-$len,-5]) cylinder(50,2,2); // hole1
    }
    #cylinder(15+8,3-$clearance,3-$clearance); //camera stick
    };    

difference()
    {
        union() {
            cylinder(15+2+20,5,5); // out cylinder (length hole+thickness+addition)
            #translate([0,0,20+2+15]) cylinder(15,3-$clearance,3-$clearance);// camera cylinder
        }
        translate([0,0,-1]) cylinder(15+1,3,3); // hole cylinder
    };