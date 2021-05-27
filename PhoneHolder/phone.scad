// Added +1 to ignore the variables in customizer
$fn=100+1;

distance_between_screws=30;
screw_head = 6+1;
screw_hole = 2+1;
center_screw_hole = 6+1;

thickness=3; // min/max: [2:5]
bezel=4; // min/max: [1:9] 
connector_width = 12; // min/max: [10:100] 

phone_width=76; // min/max: [40:200]
phone_height=80; // min/max: [45:200]
phone_thickness=13; // min/max: [5:20]

phonemodel=[76,80,13];

module backplateone(phone = phonemodel) {
	backplate(phone[0], phone[1], phone[2]);
}

module backplate(width, height, phone_thickness) {
    difference(){
        //base cube
        //Curved edges
        translate([0,thickness/2,thickness*1.4]) 
            minkowski(){
                cube([height-thickness*2, width-thickness, phone_thickness-thickness]);
                cylinder(r=thickness,h=0.1);
                rotate(a=90,v=[1,0,0])cylinder(r=thickness,h=0.1);
                rotate(a=90,v=[0,1,0])cylinder(r=thickness,h=0.1);
            }

        //remove center screw hole
        translate([height/2, width/2,-thickness]) cylinder(r=screw_hole/2,h=thickness*2+1);
		translate([height/2, width/2,thickness-2]) cylinder(r=screw_head/2,h=3);
			
        //add pins
        translate([height/2+distance_between_screws/2, width/2,-thickness]) sphere(4);		
        translate([height/2-distance_between_screws/2, width/2,-thickness]) sphere(4);

        //remove a flattened cylinder to get inner curve
        translate([0, width/2,thickness*2]) 
            resize(newsize=[height+thickness+.1,width,thickness*2])
                rotate(a=90, v=[0,1,0]) cylinder(h=height,r=width);

        //remove a concave cube to get inner curve
        translate([-thickness*2,thickness*-2,1]) {
            difference(){
                translate([0,0,phone_thickness*-1]) cube([height+thickness*2, width+thickness*4, phone_thickness]);
                translate([0,width/2+thickness*2,0]) resize(newsize=[height+thickness*2,width+thickness*4,thickness*2]) 
					rotate(a=90, v=[0,1,0]) cylinder(h=height,r=width);
            }
        }
       
        //remove the phone shape
        translate([0,0,thickness*1.5]) cube([height+thickness+.1, width, phone_thickness]);
        //remove the front opening
        translate([thickness+bezel,bezel,phone_thickness+thickness*1.49]) cube([height-bezel+.1, width-bezel*2, thickness]);
        //remove the front connector
        translate([-10,width/2-connector_width/2,thickness+2]) cube([20, connector_width, phone_thickness*2]);
        //remove the eccess bezel
        /*translate([bezel,-thickness-2,phone_thickness+thickness*1.49]){
            cube([height/1.5, width+thickness*4, thickness]);
        }*/

    }
	 //add pins
        translate([height/2+distance_between_screws/2, width/2,-thickness+1.5]) sphere(4);		
        translate([height/2-distance_between_screws/2, width/2,-thickness+1.5]) sphere(4);
}


//backplate(phone_width, phone_height, phone_thickness);
backplateone(phonemodel);