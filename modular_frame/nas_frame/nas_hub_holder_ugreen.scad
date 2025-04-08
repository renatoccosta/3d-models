use <../modules/faceplate_2u.scad>
include <../modules/base_variables.scad>

hubD = [10.1,30.1];
hubWallThik = 2;
hubWallD = [hubD.x + hubWallThik*2, hubD.y + hubWallThik*2];
hubWallHeight = 14;

hubScale = 1.5;

difference() {
    union() {
        faceplate(1);
        difference() {
            translate([(_1u-hubWallD.x)/2,margins.y,0])
                linear_extrude(hubWallHeight) 
                    square(hubWallD);
            
            translate([_1u/2+hubD.x/2-eps/2,margins.y+hubWallD.y/2,hubWallHeight]) 
                rotate([0,90,0]) 
                    linear_extrude(hubWallThik+eps) 
                        circle(3);
        }
    }
    translate([(_1u-hubD.x)/2,margins.y+(hubWallD.y-hubD.y)/2,-eps/2]) 
        linear_extrude(hubWallHeight+eps) 
            square(hubD);
}
