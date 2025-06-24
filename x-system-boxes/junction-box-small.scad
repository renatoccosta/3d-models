include <BOSL2/std.scad>
include <BOSL2/rounding.scad>

eps=.1;
boxD=[50,50,15];
wallThikness=1.5;


difference() {
    union() {
        difference() {
            cube(boxD);
            translate([wallThikness,wallThikness,wallThikness+eps]) 
                cube(boxD-[wallThikness*2,wallThikness*2,wallThikness]);
        }
        cube([boxD.x/4,boxD.y/4,boxD.z]);
        translate([boxD.x-boxD.x/4,boxD.y-boxD.y/4,0]) cube([boxD.x/4,boxD.y/4,boxD.z]);
    }

    translate([-eps/2,boxD.y-wallThikness-10,boxD.z-10]) cube([wallThikness+eps,10,10+eps]);
    translate([boxD.x-wallThikness-10,-eps/2,boxD.z-10]) cube([10,wallThikness+eps,10+eps]);
}