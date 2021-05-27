use<socket.scad>;
use<phone.scad>;
use<car.scad>;
use<car_clip.scad>;
use<cars.scad>;
use<phones.scad>;
use<magnetic.scad>;

phone_width=76; // min/max: [40:200]
phone_thickness=13; // min/max: [5:20]
phone_height=80; // min/max: [45:200]
thickness=3; // min/max: [2:5]
bezel=4; // min/max: [1:9] 
connector_width = 12; // min/max: [10:100] 

color("gray") translate([-180,80,0]) car_magclip();
color ("red") Stem ();
translate([0,-80,0]) color ("green") Nut();
translate([0,80,0]) color ("blue") Base ();

translate([80,0,0]) rotate([0,270,180]) backplateone(getphone("A2LiteCover"));

translate([-180,0,0]) car_holder();

translate([-80,-80,0]) car_clip();