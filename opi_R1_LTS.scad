include <polyround.scad>

eps = 1;

$fn=50;
_1u = 44;
M3 = 3;
M5 = 5;
boardThikness = 1.6;

thikness = 3;
frameHeight = _1u;
frameWidth = 3 * _1u;

holeOffset = 5.5;

marginLeftRight = 2 * holeOffset;
marginTopBottom = 5;
        
baseWidth = 56;
baseHeight = 8;
baseThickness = 5;
baseHolderHeight = 3;
basePanLeft = 0;
basePanBottom = 0;
    
difference() {
    translate([-marginLeftRight-basePanLeft, -marginTopBottom-basePanBottom, 0]) {
        //faceplate
        difference() {
            cube([frameWidth, frameHeight, thikness]);

            screwHoles();
        }
        
        *innerSpace();
    }
        
    boardFace();
}

translate([0, 0, thikness]) {
    //board
    *translate([0,boardThikness + baseThickness + baseHolderHeight,0]) 
        rotate([90,0,0])
            color("SeaGreen", .5) 
                cube([57, 55.5, boardThikness]);

    rotate([0,-90,-90]) {    
        base();
    }
}

module screwHoles() {
    //fixing screw holes
    translate([0, frameHeight / 2, -eps / 2]) {
        translate([holeOffset, 0, 0]) {
            //screwHole(M5);
            cylinder(h=thikness+eps, d1=7, d2=M5);
        }
        translate([frameWidth - holeOffset, 0, 0]) {
            cylinder(h=thikness+eps, d1=7, d2=M5);
        }
    }  
}

module boardFace() {
    boardX = 60;
    
    //ethernet, power, reset
    translate([(baseHeight/2)+3, baseThickness + baseHolderHeight + boardThikness, -eps/2]) {
        cube([16, 14, thikness+eps]);
        translate([16 + 2,0,0]) {
            cube([16, 14, thikness+eps]);
            translate([16 + 3, 0, 0]) {
                cube([10, 3.3, thikness+eps]);
                translate([9 + 3, 0, 0]) {
                    cube([5, 5, thikness+eps]);
                }
            }
        }
    }
    
    //board groove
    translate([0,baseThickness + baseHolderHeight,thikness-1]) 
        cube([boardX,boardThikness+.1,1+eps]);
    
    translate([boardX/2,0,0]) leds();
}

module leds() {
    ledDiam = 3;
    ledSpace = 2;
    
    for(i = [0:2]) {
        translate([i*(ledDiam+ledSpace), 0, -eps/2]) {
            translate([ledDiam/2, ledDiam/2, 0]) cylinder(h=thikness+eps, d=ledDiam);
        }
    }
}

module base() {
    //left
    translate([3,baseHeight/2,0]) {
        difference() {
            union() {
                translate([-3,-baseHeight/2,0]) support();
                cylinder(h=baseThickness + baseHolderHeight, d=5);
                translate([49,0,0]) cylinder(h=baseThickness + baseHolderHeight, d=5);
            }
        
            translate([0,0,-(eps/2)]) {
                cylinder(h=baseThickness + baseHolderHeight + eps, d=3);
                translate([49,0,0]) cylinder(h=baseThickness + baseHolderHeight + eps, d=3);
            }
        }
        
        //right
        translate([0, 50, 0]) {
            difference() {
                union() {
                    translate([-3,-baseHeight/2,0]) support();
                    translate([17,0,0]) cylinder(h=baseThickness + baseHolderHeight, d=5);
                    translate([49,0,0]) cylinder(h=baseThickness + baseHolderHeight, d=5);
                }
            
                translate([0,0,-(eps/2)]) {
                    translate([17,0,0]) cylinder(h=baseThickness + baseHolderHeight + eps, d=3);
                    translate([49,0,0]) cylinder(h=baseThickness + baseHolderHeight + eps, d=3);
                }
            }
        }
    }
}

module support() {
    linear_extrude(baseThickness, center=false) 
        polygon(polyRound([[0,0,0], [baseWidth,0,3], [baseWidth,baseHeight,3], [0,baseHeight,0]]), 50);
}

module innerSpace() {
    translate([marginLeftRight, marginTopBottom, -eps / 2]) {
        color("Tomato", .5) cube([frameWidth - 2 * marginLeftRight, 
            frameHeight - (2 * marginTopBottom),
            80 + eps]);
    }
}
