include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <variables.scad>
use <common-modules.scad>

holderR=50;
holderHeight=100+sidesThikness/2;

center();
for(x=[1:1:3])
    rotate([0,0,(360/3)*x]) translate([holderR+sidesThikness/2,0,sidesThikness/2]) feet();

module center() {
    rotate_extrude() translate([holderR,0,0]) sideFrame2d();
}

module feet() {
    translate([-sidesThikness/2,-sidesThikness/2,0]) linear_extrude(holderHeight) sideFrame2d();
    translate([0,-standFixSize/2,holderHeight+standFixSize]) rotate([-90,0,0]) doubleClip();
    corner();
}

module corner() {
    translate([0,0,holderHeight]) mirror([0,0,1]) prismoid(size1=[10,10],size2=[0,0],h=25,shift=[0,0],rounding=[0,0,0,0]);
}