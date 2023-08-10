include <polyround.scad>

eps = 1;

$fn=50;
_1u = 44;

face = [2 * _1u, _1u, 2];

holeOffset = 5.5;

marginLeftRight = 2 * holeOffset;
marginTopBottom = 5;


translate([0,0,-face.z]) {
    difference() {
        translate([-marginLeftRight, -marginTopBottom, 0]) {
            //faceplate
            difference() {
                linear_extrude(face.z) square([face.x, face.y]);
                screwHoles();
            }
        }
        
        translate([7.5,9.25,0]) boardMask();
        #translate([0,3.5,+1]) linear_extrude(1+eps) square([65,15]);
    }
}

boardSupport();

module screwHoles() {
    //fixing screw holes
    translate([0, face.y / 2, -eps / 2]) {
        translate([holeOffset, 0, 0]) {
            //screwHole(M5);
            cylinder(h=face.z+eps, d1=7, d2=4);
        }
        translate([face.x - holeOffset, 0, 0]) {
            cylinder(h=face.z+eps, d1=7, d2=4);
        }
    }  
}


module boardMask() {
    maskX = 47;
    
    translate([0,0,-eps/2])
    linear_extrude(face.z+eps) 
        polygon([[0,0],[maskX,0],[maskX,14.5],[15,14.5],[15,17],[0,17]]);
}

module boardSupport() {
    support = [8.5, 100, 3.5];
    slotX = 65;
    radiiSupportPoints = [
        [0,0,0],
        [0,support.y,3],
        [support.x,support.y,3],
        [support.x,support.y/2,7],
        [support.x*2,support.y/2.5,7],
        [support.x*2,support.z,12],
        [slotX-support.x,support.z,12],
        [slotX-support.x,support.y,3],
        [slotX,support.y,3],
        [slotX,0,0]
    ];
    
    translate([0,support.z,0]) rotate([90,0,0]) {
        difference() {
            linear_extrude(support.z) 
                polygon(polyRound(radiiSupportPoints));
            translate([3+1.5,0,-eps/2]) {
                translate([0,3,0]) linear_extrude(support.z+eps) circle(1.5);
                translate([0,3+93.5,0]) linear_extrude(support.z+eps) circle(1.5);
            }
            translate([slotX-3-1.5,0,-eps/2]) {
                translate([0,3,0]) linear_extrude(support.z+eps) circle(1.5);
                translate([0,3+93.5,0]) linear_extrude(support.z+eps) circle(1.5);
            }
        }
    }
}