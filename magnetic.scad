$fn=100;
clip_angle=0;
length=25;
width=25;
thin=2.5;
thick=5;
plate=45;
rounded=2;
magnet_r=5;
magnet_h=4;

module car_magclip() {
		
	difference() {
		union() {
			translate([0, 15, width/2]) sphere(4); // top point
			translate([0, -15, width/2]) sphere(4); // bottom point
			
			rotate([0,0,clip_angle]) translate([-thick/2,0,12.5]) minkowski() {	
				cube([thick,plate,width-rounded], center=true);
				rotate([0,90,0]) cylinder(0.001,rounded);
			}
		
		}
		translate([-thick, 15, width/2]) sphere(4); // top point
		translate([-thick, -15, width/2]) sphere(4); // bottom point
		translate([-thick*2,0,12.5]) rotate([0,90,0]) cylinder(r=1,h=thick*3,$fn=50); // central point
		translate([-thick-0.01,0,12.5]) rotate([0,90,0]) cylinder(r=3,h=1.5,$fn=50); // central point
		// magnetic holes
		translate([-magnet_h+0.01,magnet_r+2,width/2+magnet_r+2])rotate([0,90,0]) cylinder(magnet_h,magnet_r,magnet_r); 
		translate([-magnet_h+0.01,magnet_r+2,width/2-magnet_r-2])rotate([0,90,0]) cylinder(magnet_h,magnet_r,magnet_r); 
		translate([-magnet_h+0.01,-magnet_r-2,width/2+magnet_r+2])rotate([0,90,0]) cylinder(magnet_h,magnet_r,magnet_r); 
		translate([-magnet_h+0.01,-magnet_r-2,width/2-magnet_r-2])rotate([0,90,0]) cylinder(magnet_h,magnet_r,magnet_r); 
	}
}

car_magclip();

