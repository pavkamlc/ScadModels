difference() {
	import("/home/mlcochp/Stažené/files/Rpi_camera_bed_mount_for_anet_a8_v3.stl");

	translate([-18.5,20,0]) color("red") cube([10,30,100]);
	translate([-10,20,17]) color("blue") cube([10,30,100]);
}

translate([-9,28,0]) color("black") cube([4,12,100]);
