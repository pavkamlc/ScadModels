$fn=100;

$base_x=100;
$base_y=30;
$base_z=5;
$top_z=20;
$switch_x=25;
$switch_y=11;

$hole=5;

difference()
    {
    union() {
        //  wallmount
        cube([$base_x,$base_y,$base_z]);
        // base plate    
        translate([$hole*4,0,0]) cube([$base_x-$hole*8,$base_y,$top_z]);
        }

    //screw hole
    translate([0+$hole*2,$base_y/2,0]) cylinder($base_z,$hole/2,$hole/2);
    
    //screw hole
    translate([$base_x-$hole*2,$base_y/2,0]) cylinder($base_z+1,$hole/2,$hole/2);
    
    // top hole
    translate([$base_x/2-$switch_x/2,$base_y/2-$switch_y/2,$base_z]) 
    cube([$switch_x,$switch_y,$top_z-$base_z]);
    
    // bottom hole
    translate([$hole*4+2,2,0-4]) cube([$base_x-$hole*8-4,$base_y-4,$top_z]);
    
    // screw hole
    translate([$base_x/2,$base_y/2-$hole/4+12,0]) cylinder(100,$hole/4,$hole/4);
    translate([$base_x/2,$base_y/2-$hole/4-10,0]) cylinder(100,$hole/4,$hole/4);  
    
    // wire hole
    translate([$base_x/2,$base_y/2+$hole,$top_z/2]) rotate([0,90,0]) cylinder(100,$hole,$hole);
  }
  
  
 