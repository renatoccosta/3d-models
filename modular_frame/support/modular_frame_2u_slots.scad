include <../modules/base_variables.scad>
use <threads.scad>

face = [2 * _1u, 2 * _1u, 2];

holeOffset = 5.5;
sideBorder = 3;

rodHoleR = 3.25;
rodHolePosX = 10;
rodSupportDim = [12.5, rodHolePosX + rodHoleR, 3];

difference() {
    linear_extrude(face.z) square(face.x);
    translate([sideBorder, holeOffset*2, -eps/2]) linear_extrude(face.z + eps) 
        square([face.x-sideBorder*2, face.y-holeOffset*4]);
    #screwHoles();
}

translate([0,0,face.z]) rodSupport();
translate([0,face.y-rodSupportDim.x,face.z]) rodSupport();
translate([face.x-rodSupportDim.z,0,face.z]) rodSupport();
translate([face.x-rodSupportDim.z,face.y-rodSupportDim.x,face.z]) rodSupport();

module rodSupport() {
    translate([rodSupportDim.z,0,0])
    rotate([0,-90,0])
    difference() {
        union() {
            linear_extrude(rodSupportDim.z) {
                square([rodSupportDim.y,rodSupportDim.x]);
                translate([rodHolePosX + rodHoleR, rodSupportDim.x/2, 0]) circle(rodSupportDim.x/2);
            }
        }
        translate([rodHolePosX + rodHoleR, 12.5/2, -eps/2]) 
            linear_extrude(rodSupportDim.z+eps) 
                circle(rodHoleR);
    }
}

module screwHoles() {
    screwR = 2.5;
    
    //fixing screw holes
    translate([0, holeOffset, -eps/2]) {
        translate([face.x/4, 0, 0]) {
            //linear_extrude(face.z+eps) circle(screwR);
            ScrewThread(screwR*2, face.z+eps);
        }
        translate([face.x/4*3, 0, 0]) {
            //linear_extrude(face.z+eps) circle(screwR);
            ScrewThread(screwR*2, face.z+eps);
        }
    }  
    
    translate([0, face.y - holeOffset, -eps/2]) {
        translate([face.x/4, 0, 0]) {
            //linear_extrude(face.z+eps) circle(screwR);
            ScrewThread(screwR*2, face.z+eps);
        }
        translate([face.x/4*3, 0, 0]) {
            //linear_extrude(face.z+eps) circle(screwR);
            ScrewThread(screwR*2, face.z+eps);
        }
    }  
}
