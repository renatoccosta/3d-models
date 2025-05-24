include <variables.scad>
use <common-modules.scad>;

roundBaseR=17.5;
roundBaseH=46;

difference() {
    linear_extrude(roundBaseH) circle(roundBaseR);
    //translate([0,0,-eps/2]) linear_extrude(roundBaseH+eps) circle(roundBaseR/3);
    translate([0,roundBaseR/2,roundBaseH-standFixSize]) #standFix(standFixSize);
}