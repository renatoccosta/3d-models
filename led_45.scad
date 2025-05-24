eps = .1;

$fn=50;

ledSupport = [12,12,185];
pin = [2,4];

rotate([90,-90,90]) {
    difference() {
        linear_extrude(ledSupport.z) polygon([[0,0],[ledSupport.x,0],[0,ledSupport.y]]);
        translate([1.5,8.5,-eps/2]) linear_extrude(ledSupport.z+eps) rotate(-45) square([10,2]);
        translate([3,3,-eps]) linear_extrude(pin.y+eps) circle(pin.x);
    }

    translate([3,3,ledSupport.z]) linear_extrude(pin.y-eps) circle(pin.x-eps);
}