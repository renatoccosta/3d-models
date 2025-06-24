$fn=50;
eps=.1;

difference() {
    union() {
        linear_extrude(1.5) square([100,50]);

        translate([50,25,-1]) rotate([-35,0,0]) {
            cylinder(h=20,r=3.5);
            translate([0,0,20]) sphere(3.5);
        }
    }

    translate([0,0,-5]) linear_extrude(5) square([100,50]);
}