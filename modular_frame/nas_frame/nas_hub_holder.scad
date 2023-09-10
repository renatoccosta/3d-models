use <../modules/faceplate_2u.scad>
include <../modules/base_variables.scad>

hubD = [36.25,22];

hubP = [
    [0,0],
    [hubD.x,0],
    [hubD.x,15.6],
    [29.3,hubD.y],
    [0,hubD.y]
];

hubScale = 1.13;

difference() {
    union() {
        faceplate(1);
        translate([(_1u-hubD.x*hubScale)/2,margins.y,0])
            scale([hubScale,hubScale,1]) 
                linear_extrude(4*thikness) 
                    polygon(hubP);
    }
    translate([(_1u-hubD.x)/2,margins.y+(hubD.y*hubScale-hubD.y)/2,-eps/2]) 
        linear_extrude(4*thikness+eps) 
            polygon(hubP);
}


module mask() {
    linear_extrude(thikness+eps)
        polygon(hubP);
}