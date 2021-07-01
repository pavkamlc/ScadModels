$fn = 100;

knob_diameter=50; // dieameter of main sphere
knob_hole = 12; // diameter of sphere to hole
knob_deep = 6; // deep of hole created by sphere
knob_lines = 6; // how many line of holes in half of knob sphere
space_compensation = 0.65; // [0.0-1.0] bigger number, more spaces

// diameter of center hole spheres
knob_deepdiameter = knob_diameter + knob_hole - knob_deep;

difference() {
    // main sphere
    sphere(d = knob_diameter);

    // lines from top to 90grads
    for( knob_line = [0:1:knob_lines]) {

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
} 