include <BOSL2/std.scad>
include <BOSL2/shapes3d.scad>

$fn=50;

rodWidth=212;
rodD=9.5;
rodSnapWidth=6;
rodSnapD=9.4;

rotate([0,90,0]) {
    cyl(h=rodWidth,d=rodD,center=false, chamfer=1);
    //translate([0,0,-rodSnapWidth]) cyl(h=rodSnapWidth,d=rodSnapD, center=false, chamfer1=1);
    //translate([0,0,rodWidth]) cyl(h=rodSnapWidth,d=rodSnapD, center=false, chamfer2=1);
}