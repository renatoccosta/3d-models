include <BOSL2/std.scad>
include <BOSL2/rounding.scad>

$fn=50;
eps = .1;
thikness=2;
boxWidth=75;
boxHeight=25;
boxDepth=210;
magnetR=8;
magnetHeight=1.9;
magnetSlot=(magnetR+thikness+1)*2;

linear_extrude(boxWidth) top2d();
linear_extrude(thikness) side2d();
translate([0,0,boxWidth-thikness]) linear_extrude(thikness) side2d();
translate([0,0,magnetSlot]) rotate([-90,0,0]) magnetSlot();
translate([boxDepth-magnetSlot-boxHeight,0,boxWidth-magnetSlot]) rotate([-90,0,0]) mirror([0,1,0]) magnetSlot();

module side2d() {
    r=boxHeight;
    path=[[0,0],[boxDepth,0],[boxDepth,boxHeight],[0,boxHeight]];
    polygon(round_corners(path, radius=[0,0,r,0]));
}

module top2d() {
    difference() {
        side2d();
        translate([-thikness,-thikness]) side2d();
    }
}

module snapBase2d(d=10) {
    difference() {
        union() {
            square([d/2,d]);
            translate([0,d/2]) square([d+d/2,d/2]);
            translate([d/2,d/2]) circle(d=d);
        }
        translate([d/2,d/2]) translate([d,0]) circle(d=d);
    }
}

module magnetSlot() {
    d=magnetSlot;
    difference() {
        linear_extrude(thikness+1) snapBase2d(d);
        translate([d/2,d/2,-eps/2]) 
            linear_extrude(magnetHeight+eps) circle(magnetR);
    }
}