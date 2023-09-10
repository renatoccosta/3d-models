include <../modules/base_variables.scad>

face = [20, 2*_1u, 2];

rodHoleR = 3.25;
rodHolePosX = 10;
rodSupportDim = [11, rodHolePosX + rodHoleR, 3];
attachPinR = rodHoleR/2;

mirror([1,0,0]) {
    linear_extrude(face.z) square([face.x,face.y]);

    rodSupportSet();

    translate([face.x,face.y,0]) rotate([0,0,180]) rodSupportSet();
}

module rodSupportSet() {
    translate([0,0,face.z]) {
        difference () {
            rodSupport();
            translate([-eps/2,rodSupportDim.x/2,rodHolePosX/2]) rotate([0,90,0]) 
                linear_extrude(rodSupportDim.z+eps) circle(attachPinR);
        }    
        
        translate([face.x-rodSupportDim.z,0,0]) {
            rodSupport();
            translate([rodSupportDim.z,rodSupportDim.x/2,rodHolePosX/2]) rotate([0,90,0]) 
                linear_extrude(rodSupportDim.z) circle(attachPinR-.15);
        }
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
