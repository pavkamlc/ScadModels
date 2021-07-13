use <threadlib/threadlib.scad>

$fn = 80;

//diameter
diameter=100;
// profile
profile = "S100x8-int";
// grip size
grip=10;
// grip num
grips = 8;
// height
h = 30;
// thin of desk
thin = 3;
// thin of wall
wall=3;

BAREL_THREAD_TABLE = [
                   //["M100x8-int", [8, -50.6350, 100.6350, [[0, 2.9338], [0, -2.9338], [3.6825, -0.8078], [3.6825, 0.8078]]]],
                   ["S100x8-int", [8, -50, 100, [[0, 2.9338], [0, -2.9338], [3.6825, -0.8078], [3.6825, 0.8078]]]],
                   ];

difference() {
    cylinder(h, diameter/2+wall, diameter/2+wall);
    cylinder(h, diameter/2, diameter/2); 
    }
    
intersection() {
    thread(profile, turns=h/8, table=BAREL_THREAD_TABLE);
    cylinder(h, diameter/2+wall, diameter/2+wall);
    }    

cylinder(thin,diameter/2,diameter/2);

for (angle=[0:360/grips:360]) {
    handle_diameter = diameter + grip;
    translate([handle_diameter/2*sin(angle),handle_diameter/2*cos(angle),0]) cylinder(h,grip/2,grip/2);
}

