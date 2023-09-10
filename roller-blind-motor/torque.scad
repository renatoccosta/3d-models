include <BOSL2/std.scad>

$fn=50;

thikness = 8;
innerR = 12.5;
outterR = 18.25;
rightA = 56.3;
leftA = 52;

linear_extrude(thikness) difference() {
    union() {
        circle(innerR);
        rotate([0,0,-rightA/2]) 
            arc(n=$fn, r=outterR, angle=rightA, wedge=true);
        mirror([1,0,0]) 
            rotate([0,0,-leftA/2]) 
                arc(n=$fn, r=outterR, angle=leftA, wedge=true);
    }
    
    intersection() {
        circle(3.25);
        square([6.5,4.65], center=true);
    }
}
