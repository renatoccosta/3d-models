include <polyround.scad>

$fn=50;
eps = .1;
_1u=44;
thikness = 2;
canvasD = [70.5,66];

side();
!grid();

module side(sideD = [82,canvasD.y]) {
    linear_extrude(thikness) square(sideD);
    
    translate([-50,41,-2]) rotate([0,0,-45])
        for (i=[0:1:10]) {
            translate([i*12,0,0]) square([4,128]);
            translate([0,i*12,0]) square([128,4]);
        }
}

module grid(size = [100,100], slots = 10, density = .7) {
    
    slotSize = [size.x*density/slots, size.y*density/slots];
    marginSize = [(size.x-slotSize.x*slots)/slots,(size.y-slotSize.y*slots)/slots];
    
    difference() {
        linear_extrude(thikness) 
            square(size);
        translate([0,0,-eps/2]) linear_extrude(thikness + eps) 
            for (i=[0:1:slots-1]) {
                for (j=[0:1:slots-1]) {
                    translate([i*(slotSize.x+marginSize.x),j*(slotSize.y+marginSize.y)]) square(slotSize);
                }
            }
    }
}