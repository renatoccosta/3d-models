


$fn=100;

difference() {
	union () {
		translate([0,0,-3.5])
			difference() {
				translate([0,-4,0])
					cube([55,57,2],center=true);
				cube([40,40,3],center=true);
				translate([0,-26.5,0])
					cylinder(d=8,h=10,center=true);
				translate([-10,-26.5,0])
					cylinder(d=8,h=10,center=true);
				translate([10,-26.5,0])
					cylinder(d=8,h=10,center=true);
			}

		translate([-20,-22,-1])
			cylinder(d2=5,d1=8,h=7,center=true);
		translate([20,-22,-1])
			cylinder(d2=5,d1=8,h=7,center=true);
		translate([-20,20,-1])
			cylinder(d2=5,d1=8,h=7,center=true);
		translate([20,20,-1])
			cylinder(d2=5,d1=8,h=7,center=true);

		translate([-55/2+2.5,-27.5,-1.5])
			rotate([90,0,0])
				cylinder(d=6,h=10,center=true);
		translate([+55/2-2.5,-27.5,-1.5])
			rotate([90,0,0])
				cylinder(d=6,h=10,center=true);
	}

	translate([-20,-22,-1])
		#cylinder(d=2,h=8,center=true);
	translate([20,-22,-1])
		cylinder(d=2,h=8,center=true);
	translate([-20,20,-1])
		cylinder(d=2,h=8,center=true);
	translate([20,20,-1])
		cylinder(d=2,h=8,center=true);

	translate([-55/2+2.5,-27.5,-1.5])
			rotate([90,0,0])
				#cylinder(d=2.5,h=12,center=true);
	translate([+55/2-2.5,-27.5,-1.5])
			rotate([90,0,0])
				cylinder(d=2.5,h=12,center=true);
}
