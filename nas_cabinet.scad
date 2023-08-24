use <faceplate_2u.scad>
include <polyround.scad>

$fn=50;
eps = .1;
_1u=44;

faceZ = 2;
margins=[0,11];
canvasD = [70.5,66];

slotNum = 1;
slotD = [canvasD.x,canvasD.y/slotNum];
supportThikness = 2;

difference() {
    translate([-margins.x, -margins.y, 0]) 
//        faceplate(2);
        linear_extrude(faceZ) square([_1u*2,_1u]);
    for(i=[0:1:slotNum-1]) {
        translate([(_1u*2-slotD.x)/2,slotD.y*i+supportThikness,-eps/2]) 
            slotMask([slotD.x,slotD.y-supportThikness]);
    }
}

translate([(_1u*2-slotD.x-supportThikness*2)/2,0,faceZ]) {
    for(i=[0:1:slotNum-1]) {
        translate([0,slotD.y*i,0])
            slotSupport();
    }
}

module slotMask(slotD) {
    linear_extrude(faceZ+eps) square(slotD);
}

module slotSupport() {
//    linear_extrude(82) polygon(supportP);
    translate([supportThikness,0,0]) lateralSupport();
    translate([canvasD.x+supportThikness*2,0,0]) lateralSupport();
    
    translate([0,supportThikness,0]) rotate([90,0,0]) linear_extrude(supportThikness)
        shell2d(-4) {
            square([canvasD.x+supportThikness*2,82]);
            translate([-50,41,-2]) rotate([0,0,-45])
                for (i=[0:1:10]) {
                    translate([i*12,0,0]) square([4,128]);
                    translate([0,i*12,0]) square([128,4]);
                }
        }
        
}

module lateralSupport() {
    supportP = [
        [0,0,0],
        [0,10,0],
        [82,10,10],
        [82,0,0]
    ];
    
    rotate([0,-90,0])
        linear_extrude(supportThikness)
            polygon(polyRound(supportP,50));
}