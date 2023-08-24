use <faceplate_2u.scad>
include <polyround.scad>

eps = 1;

$fn=50;
_1u = 44;
M3 = 3;
M5 = 5;
boardThikness = 2;

thikness = 2;
frameHeight = _1u;
frameWidth = 3 * _1u;

holeOffset = 5.5;

marginLeftRight = 2 * holeOffset;
marginTopBottom = marginLeftRight;
        
baseWidth = 56;
baseHeight = 8;
baseThickness = 5;
baseHolderHeight = 3;
basePanLeft = 0;
basePanBottom = 0;


eth_y=3.5 + boardThikness;    
eth_z=63;

usbEthSupport();

translate([30,0,0]) {
    //board
    *translate([0,boardThikness + baseThickness + baseHolderHeight,0]) 
        rotate([90,0,0]) color("SeaGreen", .5) cube([57, 55.5, boardThikness]);

    rotate([0,-90,-90]) {    
        base();
    }
}

translate([0,0,-thikness]) {
    difference() {
        translate([-marginLeftRight-basePanLeft, -marginTopBottom-basePanBottom, 0]) {
            faceplate(4);
        }        
        #boardMask();
    }
}

module usbEthSupport() {
    translate([0,eth_y,0]) {
        linear_extrude(eth_z) {
            square([2,6]);
            translate([28,0,0]) square([2,6]);
            square([30,2]);
        }

        translate([0,0,eth_z]) linear_extrude(2) square([30,6]);

        translate([0,18,0]) linear_extrude(6) square([30,2]);

        linear_extrude(6) {
            square([2,18]);
            translate([28,0,0]) square([2,18]);
        }
    }
}

module boardMask() {
    boardX = 60;
    boardY = baseThickness+baseHolderHeight;
    ethSize = [16,11];
    
    translate([7, boardY+boardThikness,-eps/2]) 
        linear_extrude(thikness+eps) 
            square(ethSize);
    
    //texts
    translate([0,4,-eps]) linear_extrude(1+eps) {
        translate([ethSize.x+5,0,0])
            mirror([1,0,0])
                text(text="WAN2",size=3, font="Arial Rounded MT Bold:style=Regular");
        
        translate([50,0,0])
            mirror([1,0,0])
                text(text="WAN1",size=3, font="Arial Rounded MT Bold:style=Regular");
        
        translate([67,0,0])
            mirror([1,0,0])
                text(text="LAN",size=3, font="Arial Rounded MT Bold:style=Regular");
    }
    
    //ethernet, power, reset
    translate([30,0,0]) {
        translate([(baseHeight/2)+2, boardY+boardThikness, -eps/2]) {
            cube([36, 15, thikness+eps]);
            translate([36-eps,0,0]) 
                cube([20+eps, 5, thikness+eps]);
        }
        
        //board groove
        translate([0,baseThickness + baseHolderHeight,thikness-1]) 
            cube([boardX,boardThikness+.1,1+eps]);
        
        //translate([20,1,0]) 
        //    leds();
    }
}

module leds() {
    ledDiam = 3.5;
    ledSpace = 3;
    
    for(i = [0:2]) {
        translate([i*(ledDiam+ledSpace), 0, -eps/2]) {
            translate([ledDiam/2, ledDiam/2, 0]) cylinder(h=thikness+eps, d=ledDiam);
        }
    }
}

module base() {
    fixinBaseD = 5;
    fixinHoleD = 2.7;
    
    //left
    translate([3,baseHeight/2,0]) {
        difference() {
            union() {
                translate([-3,-baseHeight/2,0]) support();
                cylinder(h=baseThickness + baseHolderHeight, d=fixinBaseD);
                translate([49,0,0]) cylinder(h=baseThickness + baseHolderHeight, d=fixinBaseD);
            }
        
            translate([0,0,-(eps/2)]) {
                cylinder(h=baseThickness + baseHolderHeight + eps, d=fixinHoleD);
                translate([49,0,0]) cylinder(h=baseThickness + baseHolderHeight + eps, d=fixinHoleD);
            }
        }
        
        //right
        translate([0, 50, 0]) {
            difference() {
                union() {
                    translate([-3,-baseHeight/2,0]) support();
                    translate([17,0,0]) cylinder(h=baseThickness + baseHolderHeight, d=fixinBaseD);
                    translate([49,0,0]) cylinder(h=baseThickness + baseHolderHeight, d=fixinBaseD);
                }
            
                translate([0,0,-(eps/2)]) {
                    translate([17,0,0]) cylinder(h=baseThickness + baseHolderHeight + eps, d=fixinHoleD);
                    translate([49,0,0]) cylinder(h=baseThickness + baseHolderHeight + eps, d=fixinHoleD);
                }
            }
        }
    }
}

module support() {
    linear_extrude(baseThickness, center=false) 
        polygon(polyRound([[0,0,0], [baseWidth,0,3], [baseWidth,baseHeight,3], [0,baseHeight,0]]), 50);
}
