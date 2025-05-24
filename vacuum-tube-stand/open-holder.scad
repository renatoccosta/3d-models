include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <variables.scad>
use <common-modules.scad>

champferR=3;
holderHeight=90;
sidesDistance=75;
holderR=55;

translate([0,-standFixSize,-standFixSize/2])
    doubleClip(standFixSize);

difference() {
    union() {
        for(x=[0:1:1])
            mirror([x,0,0])
                translate([sidesDistance/2-sidesThikness,0,standFixSize/2]) 
                    rotate([-90,0,0]) 
                        linear_extrude(holderHeight+holderR) sideFrame2d();

        translate([-(sidesDistance-sidesThikness)/2,0,sidesThikness/2]) 
            rotate([0,90,0]) 
                linear_extrude(sidesDistance-sidesThikness) 
                    bottomFrame2d();
    }

    translate([0,holderR+holderHeight,-(sidesThikness+eps)/2]) 
        linear_extrude(sidesThikness+eps) 
            circle(holderR);
}

difference() {
    translate([0,holderR+holderHeight,-sidesThikness/2]) rotate([0,0,-17.5]) 
        rotate_extrude(angle=-145) translate([holderR-sidesThikness/2,0]) #sideFrame2d();
    
    for(x=[0,1,1]) mirror([x,0,0])
        translate([0,holderR+holderHeight,0]) rotate([0,0,-72.5-.01]) 
            translate([0,-holderR,0]) rotate([-90,0,90]) 
                #pointMask();
}

module pointMask() {
    r=7;
    translate([0,0,-r]) {
        difference() {
            linear_extrude(r) scale(1.05) translate([-sidesThikness/2,-sidesThikness/2]) sideFrame2d();
            sphere(r);
        }
        translate([0,0,6]) linear_extrude(1) circle(4);
    }
}

module testPointMask() {
    translate([0,holderR+holderHeight,0]) 
        rotate([0,0,-72.5]) 
            translate([0,-holderR,0]) 
                rotate([-90,0,90]) 
                    #pointMask();
}

//testPointMask();