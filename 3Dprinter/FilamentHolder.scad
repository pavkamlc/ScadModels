$fn=50;
$thin=5;
$length=180;
$axe=10;
$width=20;
$holeposition=46.5;
$rounding=3;

difference()
{
    // body
    union()
    {
    cube([$thin,$width,$holeposition+10]);
    translate([-$length,0,0]) cube([$length+$width,$width,$thin]);
    cube([$width,$width,10]);
	translate([0,$width/2,0])
		rotate([0,270,90]) 
			linear_extrude(height = $thin, center = true)
				polygon(points=[[0,0],[40,0],[0,90]], paths=[[0,1,2]]);
    }
    
    // screw hole
    translate([0,10,$holeposition]) rotate([0,90,0]) cylinder(100,2,2);
    
    // holder hole
    translate([$thin,10-4,$thin]) cube([40,8,40]);
    translate([$thin,0,$thin]) cube([8,$width,$width]);

    // top hole
    translate([-$length+10,10,0]) rotate([0,0,90]) cylinder(100,$axe/2,$axe/2);
    translate([-$length,5,0]) cube([10,10,20]);

	// cosmetics
	translate([$width,$width,0]) roundcorner($rounding,0);
	translate([$width,0,0]) roundcorner($rounding,270);
	translate([-$length,$width,0]) roundcorner($rounding,90);
	translate([-$length,0,0]) roundcorner($rounding,180);	
	translate([0,$width,$holeposition+10]) rotate([0,90,0]) roundcorner($rounding,90);
	translate([0,0,$holeposition+10]) rotate([0,90,0]) roundcorner($rounding,180);
}

module roundcorner(rounding, angle)
{
	rotate([0,0,angle])
	difference()
	{
		translate([-rounding,-rounding,0]) 
			cube([rounding*2,rounding*2,100]);
		translate([-rounding,-rounding,0])
			cylinder(100,rounding,rounding);
	}
}





