include<NopSCADlib/utils/core/core.scad>;
use <NopSCADlib/utils/thread.scad>

$fn = 100;

// binary masks
KNOB_TOP_TOYOTA = 1;
KNOB_BOTTOM_VW = 2;
KNOB_TOP_GOLF = 3;
KNOB_NUMBERS5 = 4;
KNOB_NUMBERS6 = 5;
KNOB_BOTTOM_TOYOTA = 6;
KNOB_KONVEX = 7;

knob_diameter=50; // dieameter of main sphere
knob_hole = 12; // diameter of sphere to hole
knob_deep = 6; // deep of hole created by sphere
knob_lines = 6; // how many line of holes in half of knob_all sphere
space_compensation = 0.65; // [0.0-1.0] bigger number, more spaces

// diameter of center hole spheres
knob_deepdiameter = knob_diameter + knob_hole - knob_deep;

// main part
knob_all(knob_type = [KNOB_TOP_TOYOTA, KNOB_BOTTOM_TOYOTA, KNOB_KONVEX]);

// infill part
translate([100,0,0]) knob_in(knob_type = [KNOB_TOP_TOYOTA]);

// main module
module knob_all(knob_type = [KNOB_TOP_TOYOTA, KNOB_BOTTOM_TOYOTA]) {
    difference() {
        // main body
        knob_sphere(knob_type);
        
        // relief
        knob_sub(knob_type);

        // mount
        knob_mnt(knob_type);
    }
}

// infill
module knob_in(knob_type) {
    intersection() {
        knob_sphere();

        // mount
        knob_sub(knob_type);
    }
}

// main sphere
module knob_sphere(knob_type) {
    // konvex largerer
    if(search(KNOB_KONVEX, knob_type))
        translate([0,0,-30]) largerer(19, 13);
    
    sphere(d = knob_diameter);
}

module knob_sub(knob_type) {
    // hole for reverse shifting
    if(search(KNOB_BOTTOM_TOYOTA,knob_type))
        translate([0,0,-31]) cylinder(6,12,12);

    if(search(KNOB_TOP_GOLF, knob_type)) // golf knob_all        
        for( knob_line = [0:1:knob_lines]) { // lines from top to 90grads

            // angle of line
            knob_angle_horiz = knob_line * (180 / knob_lines);

            // diameter of this line
            line_diameter = sin(knob_angle_horiz) * knob_deepdiameter/2;

            // number of holes in this line 
            hole_numbers = ceil (line_diameter * PI / (space_compensation * knob_hole));

            // angle between of holes in one line
            knob_step = 360/hole_numbers;

            // holes in one line
            for(knob_angle_vert = [0:knob_step:360+knob_step]) {
                translate([ sin(knob_angle_horiz) * sin(knob_angle_vert) * knob_deepdiameter/2, 
                    sin(knob_angle_horiz) * cos(knob_angle_vert) * knob_deepdiameter/2, 
                    cos(knob_angle_horiz) * knob_deepdiameter/2 ]) 
                    sphere(d = knob_hole);
            }

            // debuging
            echo(str("knob_line = ", knob_line));
            echo(str("hole_numbers = ", hole_numbers));
        }
    if(search(KNOB_TOP_TOYOTA, knob_type)) // toyota logo
        translate([-15, -10, 15]) 
            resize(newsize=[30,20,10]) 
                linear_extrude(5) 
                    offset(r=1)
                        import("./Toyota_EU.svg"); 
}

module knob_mnt(knob_type) {
    // M12x1.25 for toyota 2006-2008
    if(search(KNOB_BOTTOM_TOYOTA, knob_type))
        translate([0,0,-30]) male_metric_thread(d = 12, pitch = 1.25, length = 20, center = false, top = -1, bot = -1, solid = true, colour = undef);
}

module largerer(radius=25, radius_base=20) {
    intersection() {
        konvex(radius, radius_base);
        cylinder(40,radius_base+5,radius_base+5);
    }
}

module konvex(radius, radius_base) {
    rotate_extrude(convexity = 10)
        translate([radius+radius_base, 0, 0]) 
            difference() {
                polygon(points=[[0,0],[-radius-radius_base,0],[-radius-radius_base,radius],[0,radius]]);
                circle(r = radius, $fn = 100);
            }
}
