include <polyround.scad>

eps = 1;

$fn=50;
_1u = 44;
boardThikness = 2;

thikness = 2;

baseHeight = 8;
baseThickness = 3;
baseHolderHeight = 3;

eth_y=baseThickness + .5;    
eth_z=62;

difference() {
    translate([-4,-5,-2]) linear_extrude(2) square([100,35]);
    routerMask(thikness);
}
routerSupport();

module routerMask(faceThikness=2) {
    boardX = 60;
    boardY = baseThickness+baseHolderHeight;
    ethSize = [16,11];
    
    translate([0,0,-thikness]) {
        //usb eth
        translate([7, boardY+boardThikness,-eps/2]) 
            linear_extrude(faceThikness+eps) 
                square(ethSize);
        
        //ethernet, power, reset
        translate([29,0,0]) {
            translate([(baseHeight/2)+2, boardY+boardThikness, -eps/2]) {
                linear_extrude(faceThikness+eps) 
                    polygon([[0,0],[0,15],[36,15],[36,5],[56,5],[56,0]]);            
            }
            
            //board groove
            translate([0,baseThickness + baseHolderHeight,faceThikness-1]) 
                cube([boardX,boardThikness+.1,1+eps]);        
        }
        
        //texts
        translate([0,2,-eps]) linear_extrude(1+eps) {
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
    }
}

module routerSupport() {
    //usb-eth support
    translate([0,eth_y,0]) {
        linear_extrude(eth_z) {
            square([2,4]);
            translate([28,0,0]) 
                square([2,4]);
            square([30,2]);
        }

        translate([0,0,eth_z]) 
            linear_extrude(2) 
                square([30,4]);

        translate([0,18,0]) 
            linear_extrude(4) 
            square([30,2]);

        linear_extrude(4) {
            square([2,18]);
            translate([28,0,0]) 
                square([2,18]);
        }
    }
    
    translate([30,0,0]) rotate([-90,0,0]) mirror([0,1,0]) {
        px = [[4,3],[4,52],[54,20],[54,52]];
        
        difference() {
            union() {
                linear_extrude(baseThickness) 
                    polygon(polyRound([[0,0,0],[0,56,5],[8,56,5],[8,8,5],[50,8,5],[50,56,5],[58,56,5],[58,0,0]]), 50);
            
                for(i = [0:len(px)-1]) {
                    translate(px[i])
                        linear_extrude(baseThickness + baseHolderHeight) 
                            circle(2.5);
                }
            }
            
            translate([0,0,-(eps/2)]) {
                for(i = [0:len(px)-1]) {
                    translate(px[i])
                        linear_extrude(baseThickness + baseHolderHeight + eps) 
                            circle(1.35);
                }
            }
        }
    }
}

