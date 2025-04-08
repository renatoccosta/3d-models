include <polyround.scad>
include <../modules/base_variables.scad>
use <../modules/faceplate_2u.scad>
use <./nas_cabinet2.scad>


canvasD = [74,2*_1u - 2*margins.y];
frame(canvasD);
    
translate([(_1u*2-canvasD.x)/2,margins.y,0]) 
    cabinet([canvasD.x-2*thikness,canvasD.y-2*thikness, 65]);

module frame(canvasD) {
    difference() {
        faceplate(2);
        translate([(_1u*2-canvasD.x)/2, (_1u*2-canvasD.y)/2, -eps/2]) 
            linear_extrude(thikness + eps) 
                square(canvasD);
    }
}

module brackets(canvasD) {
    bracketD = [10,10,thikness];
    translate([0,0,thikness]) {
        left = (_1u*2-canvasD.x)/2-2*thikness;
        right = (_1u*2-canvasD.x)/2+canvasD.x+2*thikness;
        top =  (_1u*2-canvasD.y)/2+canvasD.y-bracketD.y+thikness;
        bottom =  (_1u*2-canvasD.y)/2-thikness;
        translate([left,top,0]) bracket(bracketD);
        translate([left,bottom,0]) bracket(bracketD);
        translate([right,top,0]) mirror([1,0,0]) bracket(bracketD);
        translate([right,bottom,0]) mirror([1,0,0]) bracket(bracketD);
    }
}

module bracket(bracketD = [20,10,2]) {
    bracketP = [
        [0,0,0],
        [0,bracketD.y,0],
        [bracketD.x,bracketD.y,bracketD.y],
        [bracketD.x,0,bracketD.y]
    ];
    
    screwHoleR1 = 2;
    screwHoleR2 = 3.5;
    boltHeadZ = 1;
    
    translate([bracketD.z,0,0]) rotate([0,-90,0])
    difference() {
        linear_extrude(bracketD.z) polygon(polyRound(bracketP,50));
        translate([bracketD.x-bracketD.y/2,bracketD.y/2, 0]) {
            translate([0, 0, -eps/2]) 
                linear_extrude(bracketD.z + eps) 
                    circle(screwHoleR1);
            translate([0, 0, bracketD.z-boltHeadZ]) 
                linear_extrude(boltHeadZ+eps) 
                    circle(screwHoleR2);
        }
    }
}