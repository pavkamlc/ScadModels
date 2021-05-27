$fn=100;
//$fn=20;

/*[ Light end ]*/
inner_ring=12.25; // [50:large,25:medium,15:small]
outer=17;
depth=30;

cooler=2; // 1 or 2
cooler_cube=15.5;
cooler_air=3;
screw=10;

deckel=3; // 1 or 2 or 3

width_base=60;
length_base=100;


difference() {
    //body
    union() {
        
        difference() {
            union(){
            //outer ring
            cylinder(depth-10,outer,outer);
            translate([0,0,5])cylinder(depth-5,outer+5,outer+5);
            //holder
            linear_extrude(height=depth) polygon([[0,0],[width_base/2,length_base],[-width_base/2,length_base]]);
            //rounded corner
            rotate_extrude(angle=360)translate([outer,5,0]) circle(5);
            }
        // glass hole
        translate([0,0,5])cylinder(depth,outer, outer);
        }
   
    //inner ring
    translate([0,0,0]) cylinder(depth,inner_ring,inner_ring);
    }  

    //cooler hole
    translate([-cooler_cube/2,-cooler_cube/2,5]) cube([cooler_cube,cooler_cube,depth]);
    
    // air cooling
	if(cooler==1)
	{
		translate([cooler_cube-5.25,0,-40]) cylinder(100,cooler_air/2,cooler_air/2);
		translate([-cooler_cube+5.25,0,-40]) cylinder(100,cooler_air/2,cooler_air/2);
		translate([0,cooler_cube-5.25,-40]) cylinder(100,cooler_air/2,cooler_air/2);
		translate([0,-cooler_cube+5.25,-40]) cylinder(100,cooler_air/2,cooler_air/2);
	}
    else if(cooler==2)
	{
		// moon air cooling
		difference() {
		cylinder(70,11,11);
		translate([-9,-9,0]) cube([18,18,90]);
		}
    }
    
    //right small hole
    translate([width_base/4,length_base-25,depth/2]) rotate([0,90,90]) cylinder(100,2,2);
    //right big hole
    translate([width_base/4,length_base-25,depth/2]) rotate([0,90,90]) cylinder(15,screw/2,screw/2);
    //left small hole
    translate([-width_base/4,length_base-25,depth/2]) rotate([0,90,90]) cylinder(100,2,2);
    //left big hole
    translate([-width_base/4,length_base-25,depth/2]) rotate([0,90,90]) cylinder(15,screw/2,screw/2);
    
	if(deckel==1) {
		//prisma hole
		translate([-60,length_base-40,25])rotate([90,270,90]) cylinder(100,length_base/3,length_base/3,$fn=3);
	}
    else if(deckel==2) {
		// montage hole
		translate([-50,length_base-60,15]) cube([200,50,50]);
		translate([8,length_base-60,15]) rotate([0,0,90]) cylinder(100,3,3,$fn=3);
		translate([-8,length_base-60,15]) rotate([0,0,90]) cylinder(100,3,3,$fn=3);	
		translate([20,length_base-10,15]) rotate([0,0,30]) cylinder(100,3,3,$fn=3);	
		translate([-20,length_base-10,15]) rotate([0,0,30]) cylinder(100,3,3,$fn=3);		
		}
	else if(deckel==3) {
		translate([-50,length_base-60,15]) cube([200,50,50]);
		translate([5,length_base-65,15]) rotate([0,0,0]) cube([2.5,5,100]);
		translate([-7.5,length_base-65,15]) rotate([0,0,0]) cube([2.5,5,100]);
		translate([15,length_base-10,15]) rotate([0,0,0]) cube([2.5,5,100]);
		translate([-17.5,length_base-10,15]) rotate([0,0,0]) cube([2.5,5,100]);
		}
	
    //wire hole
    translate([-0,0,depth/2]) rotate([0,90,90]) cylinder(length_base+10,5,5);
}

if(deckel==1) {
	// prismatic deckel
	translate([100,0,-10]) difference() {
		{
			intersection() {
			//holder
			linear_extrude(height=depth) polygon([[0,0],[width_base/2,length_base],[-width_base/2,length_base]]);
			//prisma hole
			translate([-60,length_base-40,25])rotate([90,270,90]) cylinder(100,length_base/3-0.25,length_base/3-0.25,$fn=3);
			}
		}
		//wire hole
		translate([-0,0,depth/2]) rotate([0,90,90]) cylinder(120,5,5);
	}
}
else if(deckel==2) {
	// cube deckel
	translate([100,0,-10]) difference() union() {
		intersection() {
			//holder
			linear_extrude(height=depth) polygon([[0,0],[width_base/2,,length_base],[-width_base/2,length_base]]);
			// montage hole
			translate([-50,length_base-60,15]) cube([200,50,50]);
		}
		// prismas
		translate([8,length_base-60,15]) rotate([0,0,90]) cylinder(15,3,3,$fn=3);
		translate([-8,length_base-60,15]) rotate([0,0,90]) cylinder(15,3,3,$fn=3);	
		translate([20,length_base-10,15]) rotate([0,0,30]) cylinder(15,3,3,$fn=3);	
		translate([-20,length_base-10,15]) rotate([0,0,30]) cylinder(15,3,3,$fn=3);
		//wire hole
		translate([-0,0,depth/2]) rotate([0,90,90]) cylinder(120,5,5);
	}
}
else if(deckel==3) {
	translate([100,0,-10]) difference() {
		union() {
			intersection() {
				//holder
				linear_extrude(height=depth) polygon([[0,0],[width_base/2,,length_base],[-width_base/2,length_base]]);
				// montage hole
				translate([-50,length_base-60,15]) cube([200,50,50]);
			}
			translate([5,length_base-65,15]) rotate([0,0,0]) cube([2.5,5,15]);
			translate([-7.5,length_base-65,15]) rotate([0,0,0]) cube([2.5,5,15]);
			translate([15,length_base-10,15]) rotate([0,0,0]) cube([2.5,5,15]);
			translate([-17.5,length_base-10,15]) rotate([0,0,0]) cube([2.5,5,15]);
		}	
	//wire hole
	translate([-0,0,depth/2]) rotate([0,90,90]) cylinder(120,5,5);
	}
}

// testing area

