include <BOSL2/std.scad>
include <BOSL2/rounding.scad>

eps=.1;
boxD=[100,100,15];
wallThikness=1.5;


difference() {
    union() {
        difference() {
            cube(boxD);
            translate([wallThikness,wallThikness,wallThikness+eps]) 
                cube(boxD-[wallThikness*2,wallThikness*2,wallThikness]);
        }
        cube([16,16,boxD.z]);
        translate([boxD.x-16,boxD.y-16,0]) cube([16,16,boxD.z]);
    }

    translate([boxD.x-wallThikness-10,-eps/2,boxD.z-10]) cube([10,wallThikness+eps,10+eps]);
    translate([wallThikness,boxD.y-wallThikness-eps/2,boxD.z-10]) cube([10*3,wallThikness+eps,10+eps]);
}