use <threads.scad>

eps = 1;

$fn=50;
_1u = 44;
face = [_1u*3, 11, 2];
screwR = 2.25;

rodHoleR = 3.25;
rodHolePosX = 10;
rodSupportDim = [11, rodHolePosX + rodHoleR, 3];
attachPinR = rodHoleR/2;

difference() {
    linear_extrude(face.z) square([face.x,face.y]);
    translate([face.x/6,face.y/2,-eps/2]) ScrewThread(screwR*2, face.z+eps);
    translate([face.x/6*3,face.y/2,-eps/2]) ScrewThread(screwR*2, face.z+eps);
    translate([face.x/6*5,face.y/2,-eps/2]) ScrewThread(screwR*2, face.z+eps);
}

translate([0,0,face.z]) {
    difference () {
        rodSupport();
        translate([-eps/2,face.y/2,rodHolePosX/2]) rotate([0,90,0]) 
            linear_extrude(rodSupportDim.z+eps) circle(attachPinR);
    }    
    
    translate([(face.x-rodSupportDim.z)/3,0,0]) rodSupport();
    translate([(face.x-rodSupportDim.z)/3*2,0,0]) rodSupport();
    
    translate([face.x-rodSupportDim.z,0,0]) {
        rodSupport();
        translate([rodSupportDim.z,face.y/2,rodHolePosX/2]) rotate([0,90,0]) 
            linear_extrude(rodSupportDim.z) circle(attachPinR-.15);
    }
}



module rodSupport() {
    translate([rodSupportDim.z,0,0])
    rotate([0,-90,0])
    difference() {
        linear_extrude(rodSupportDim.z) {
            square([rodSupportDim.y,rodSupportDim.x]);
            translate([rodHolePosX + rodHoleR, rodSupportDim.x/2, 0]) circle(rodSupportDim.x/2);
        }
        translate([rodHolePosX + rodHoleR, rodSupportDim.x/2, -eps/2]) 
            linear_extrude(rodSupportDim.z+eps) 
                circle(rodHoleR);
    }
}
