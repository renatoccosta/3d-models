
$fn=50;

ep = 3;

bw = 45;

ethh = 14;
ethw = 16;

difference(){
	cube([44,88,ep]);
	translate([22,5.5,-0.5])
		#cylinder(ep+1,d=5);
	translate([22,88-5.5,-0.5])
		cylinder(ep+1,d=5);
	translate([22-15/2,44-33/2,-0.5])
		union(){
		cube([ethh,ethw,ep+1]);
		translate([0,ethw+1,0])
			cube([ethh,ethw,ep+1]);
		}
	translate([22+ethh-15/2+5,(88-bw)/2-2.5,-0.5])
		cylinder(ep+1,d=3.5);
	translate([22+ethh-15/2+5,(88-bw)/2-2.5+50,-0.5])
		cylinder(ep+1,d=3.5);
	translate([22+ethh-15/2+6,(88-bw)/2-2.5,-0.5])
		cylinder(ep+1,d=3.5);
	translate([22+ethh-15/2+6,(88-bw)/2-2.5+50,-0.5])
		cylinder(ep+1,d=3.5);
};