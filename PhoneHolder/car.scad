$fn=40;

//[height, width, topOffset, bottomOffset, hookTopDepth, hookBottomDepth, hookType]
car_param = [70,60,70,50,10,20,"in"];

thick=5;

// basic body polynom
points=polylinepoints(car_param[2], car_param[3], car_param[0]);

function polylinepoints(topOffset, bottomOffset, height) = [[0,topOffset],[0,topOffset/2],[height/5,0],[height/5*4,0],[height,bottomOffset/2],[height,bottomOffset]];

module line(p1,p2) {
    hull() {
        translate(p1) circle(0.001);
        translate(p2) circle(0.001);
    }
}

module polyline(points) {
	for(index = [1 : 1 : len(points)-1]) {
		line(points[index-1], points[index]);
		}
}

// body
module body(points, width, thick) {  
	minkowski() {
		linear_extrude(width) polyline(points);
		sphere(thick/2);
	}
}

module hooks(type, height, width, topOffset, bottomOffset, hook_topdepth, hook_bottomdepth) {
	if(type == "out") {
		// outer hook
		translate([0,topOffset-10,-width]) rotate([0,0,10]) color("red") 		cube([inner_topdepth,hook_topdepth,width*3]);
		translate([0,topOffset-0,-width]) rotate([0,0,0]) color("blue") cube([hook_bottomdepth,hook_bottomdepth,width*3]);
	}
	if(type == "in") {
		// inner hooks
		translate([-hook_topdepth,topOffset-hook_topdepth,-width]) color("red") cube([hook_topdepth,hook_topdepth,width*3]);
		translate([height,bottomOffset-hook_bottomdepth,-width]) color("black") cube([hook_bottomdepth,hook_bottomdepth,width*3]);
	}
}

module car_holder(height, width, topOffset, bottomOffset, hookTopDepth, hookBottomDepth, hookType) {
	difference() {
		body(points, width, thick);
		translate([height/2, -thick/2+10, width/2]) rotate([90,0,0]) cylinder(r=1,h=thick*3,$fn=50); //central point		
		translate([height/2+15, -thick+2, width/2]) sphere(4); // top point
		translate([height/2-15, -thick+2, width/2]) sphere(4); // bottom point
		hooks(hookType, height, width, topOffset, bottomOffset, hookTopDepth, hookBottomDepth);
	}
}

module car_holderone(car) {
	car_holder(car[0], car[1], car[2], car[3], car[4], car[5], car[6]);
}

car_holderone(car_param);
