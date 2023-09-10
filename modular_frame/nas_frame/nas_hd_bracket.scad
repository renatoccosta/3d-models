include <polyround.scad>
include <../modules/base_variables.scad>

eps = 1;

face=[2*_1u, 16.5, 2];
hardDriveD=[70,100,10];
carvingD=[50,3];
carvingP=[[0,0,0],
        [0,carvingD.y+eps,carvingD.y],
        [carvingD.x,carvingD.y+eps,carvingD.y],
        [carvingD.x,0,0]];
        
lateralHolderZ=2;
floorZ=2;

difference() {
    linear_extrude(face.z) 
        square([face.x, face.y]);
    translate([(face.x-carvingD.x)/2,-eps,-eps/2]) {
        linear_extrude(face.z+eps) 
            polygon(polyRound(carvingP,50));
        translate([carvingD.x,face.y+eps*2,0])
            rotate([0,0,180])
                linear_extrude(face.z+eps) 
                    polygon(polyRound(carvingP,50));
    }
}

translate([(face.x-hardDriveD.x)/2-lateralHolderZ,0,face.z]) 
    lateralHolder(lateralHolderZ);

translate([face.x-((face.x-hardDriveD.x)/2-lateralHolderZ),0,face.z]) 
    mirror([1,0,0])
        lateralHolder(lateralHolderZ);

module lateralHolder(thikness=2) {
    screwHoleR = 1.60;
    screwHoleR2 = 3;
    lateralHolderD = [15,8,thikness];
    lateralHolderP = [[0,0,0],
                    [0,lateralHolderD.y,0],
                    [lateralHolderD.x,lateralHolderD.y,screwHoleR2],
                    [lateralHolderD.x,0,0]];
    baseHolderD = [10,15,thikness];
    baseHolderP = [[0,0,0],
                    [0,baseHolderD.y,0],
                    [baseHolderD.x,baseHolderD.y,screwHoleR2],
                    [baseHolderD.x,0,0]];
    difference() {
        union() {
            translate([thikness,thikness,0]) {
                rotate([0,-90,0])
                    linear_extrude(lateralHolderD.z) 
                        polygon(polyRound(lateralHolderP,50));
                
                rotate([90,0,0]) 
                    linear_extrude(baseHolderD.z) 
                        polygon(polyRound(baseHolderP,50));
            }
            
            linear_extrude(lateralHolderD.x) square([thikness,thikness]);
        }
        

        translate([thikness,thikness,0]) {
            rotate([0,-90,0]) translate([10,2.75,-.1/2]) 
                cylinder(lateralHolderD.z+.1,screwHoleR,screwHoleR2);
        
            rotate([90,0,0]) translate([4,10,-.1/2]) 
                cylinder(lateralHolderD.z+.1,screwHoleR,screwHoleR2);
        }
    }
}