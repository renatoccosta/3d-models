$fn=100;
eps=.1;

difference() {
    linear_extrude(1) circle(4);
    translate([0,0,-eps/2]) linear_extrude(1+eps) circle(1.4);
}