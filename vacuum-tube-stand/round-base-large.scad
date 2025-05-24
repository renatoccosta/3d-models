include <variables.scad>
use <common-modules.scad>;

roundBaseR=30;
roundBaseH=59;

difference() {
    linear_extrude(roundBaseH) circle(roundBaseR);
    translate([0,0,-eps/2]) linear_extrude(roundBaseH+eps) circle(roundBaseR/3);
    translate([0,0,roundBaseH-standFixSize]) standFixPair(standFixSize);
    translate([0,standFixDistance/2,roundBaseH-standFixSize]) standFix(standFixSize);
}