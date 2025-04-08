include <BOSL2/std.scad>

$fn=100;

eps = .1;
depth = 4;


linear_extrude(depth) circle(50); //table
linear_extrude(depth+2) circle(5.5); //spacer
difference() {
    linear_extrude(depth+2+7) circle(4); //pin
    up(depth+2+7) #chamfer_cylinder_mask(r=4, chamfer=1);
}