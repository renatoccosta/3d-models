include <polyround.scad>

$fn=50;
eps = 1;

margins=[0,11];
switchPadding=[22,5];

faceZ = 2;
baseZ = 3;

switchBoardZ = 1;
switchBoardBottomPinsZ = 2.2;

difference() {
    translate([-5,-5, -faceZ]) 
        linear_extrude(2) square([143,35]);
    switchMask();
}

    switchSupport();

module switchMask() {
    ethsDim = [119,14];
    powDim = [10,12];
    
    translate([0,baseZ + switchBoardBottomPinsZ + switchBoardZ,-faceZ-eps/2]) 
    linear_extrude(faceZ + eps) {
        square(powDim);
        translate([powDim.x + 3, 0, 0])
            square(ethsDim);
    }
}

module switchSupport() {
    holeR = 1.25;
    
    mirror([0,1,0]) rotate([90,0,0]) translate([132,0,0]) mirror([1,0,0])
    difference() {
        union() {
            linear_extrude(baseZ) 
                polygon(polyRound([[0,0,0],[0,61.5,8],[16,61.5,9],[16,11.5,8],[66,11.5,8],[66,41.5,8],[82,41.5,8],[82,11.5,8],[132,11.5,8],[132,0,0]],50));
            translate([8,52,baseZ]) 
                linear_extrude(switchBoardBottomPinsZ) circle(4);
            translate([74,32,baseZ]) 
                linear_extrude(switchBoardBottomPinsZ) circle(4);
        }
        
        translate([8,52,-eps/2]) 
            linear_extrude(baseZ + switchBoardBottomPinsZ + eps) 
                circle(holeR);
        translate([74,32,-eps/2]) 
            linear_extrude(baseZ + switchBoardBottomPinsZ + eps) 
                circle(holeR);
    }
}

