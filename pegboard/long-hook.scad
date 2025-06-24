use <base.scad>
include <BOSL2/std.scad>
include <BOSL2/shapes2d.scad>
include <BOSL2/shapes3d.scad>

$fn=50;

pinHolder(1,2);

linear_extrude(4) rect([11,10+26],rounding=5.5);
translate([0,-5,3]) rotate([-20,0,0]) #cyl(h=60,d=5.1,center=false, rounding2=2);