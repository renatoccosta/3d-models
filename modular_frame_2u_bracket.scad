eps = 1;

$fn=50;
_1u = 44;
face = [33, 2 * _1u, 2];
screwHoleDim = [9.5,6];
holeRadius = 3.25;
holePosX = 10;
supportDim = [11, holePosX + holeRadius, 3];

attachPinR = holeRadius/2;

difference() {
    linear_extrude(face.z) square([face.x, face.y]);
    translate([4, 0, -eps/2]) {
        translate([0, 0+3, 0]) linear_extrude(face.z+eps) screwHole();
        translate([0, face.y-screwHoleDim.y-3, 0]) linear_extrude(face.z+eps) screwHole();
    }
}

translate([face.x,0,face.z]) {
    difference() {
        rodSupport();
        translate([eps/2,supportDim.x/2,holePosX/2]) rotate([0,-90,0]) 
            linear_extrude(supportDim.z+eps) circle(attachPinR);
    }
    
    translate([0,face.y-supportDim.x,0]) {
        rodSupport();
        translate([supportDim.z,supportDim.x/2,holePosX/2]) rotate([0,-90,0]) 
            linear_extrude(supportDim.z+eps) circle(attachPinR-.15);
    }
}

module screwHole() {
    translate([3,3,0]) {
        circle(3);
        translate([3.5,0,0]) circle(3);
        translate([1.5,0,0]) square([3.5,6], true);
    }
}

module rodSupport() {
    rotate([0,-90,0])
    difference() {
        union() {
            linear_extrude(supportDim.z) {
                square([supportDim.y,supportDim.x]);
                translate([holePosX + holeRadius, supportDim.x/2, 0]) circle(supportDim.x/2);
            }
        }
        translate([holePosX + holeRadius, supportDim.x/2, -eps/2]) 
            linear_extrude(supportDim.z+eps) 
                #circle(holeRadius);
    }
}