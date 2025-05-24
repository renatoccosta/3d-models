include <variables.scad>

baseH = 2.8;
padD = [5.5, boardD.y];
padH = 3;
sidesH = baseH + padH + boardH + 13;
magnetR = 16/2;
magnetH = 1.8;
magnetPos = [12,12];

difference() {
    union() {
        linear_extrude(baseH) square(boardD);
        pads();
    }
    union() {
        translate([boardD.x-magnetPos.x,magnetPos.y,-eps]) magnet();
        translate([magnetPos.x,boardD.y-magnetPos.y,-eps]) magnet();
    }
}

difference() {
    union() {
        front();
        back();
        side();
        translate([boardD.x+sidesThikness,0,0]) side();
    }
    snaps();
}

module pads() {
    innerBoardD=[70.3,50.6];
    translate([0,0,baseH]) linear_extrude(padH) square(padD);
    translate([boardD.x-padD.x,0,baseH]) linear_extrude(padH) square(padD);
    translate([0,innerBoardD.y,0]) linear_extrude(baseH + padH + boardH + 1) square([boardD.x, boardD.y-innerBoardD.y]);
}

module magnet() {
    linear_extrude(magnetH+eps) circle(magnetR);
}

module snaps() {
    snap=1;
    //front
    translate([-sidesThikness-eps/2,-sidesThikness-eps,sidesH-snap]) 
        linear_extrude(snap+eps) 
            square([boardD.x+2*sidesThikness+eps, snap+eps]);
    
    //left
    translate([-sidesThikness-eps,-sidesThikness-eps/2,sidesH-snap]) 
        linear_extrude(1+eps) 
            square([1+eps,boardD.y+2*sidesThikness+eps]);
    //right
    translate([boardD.x+snap+eps,-sidesThikness-eps/2,sidesH-snap]) 
        linear_extrude(1+eps) 
            square([1+eps,boardD.y+2*sidesThikness+eps]);
    //back
    translate([-sidesThikness-eps/2,boardD.y+snap+eps,sidesH-snap]) 
        linear_extrude(snap+eps) 
            square([boardD.x+2*sidesThikness+eps, snap+eps]);
}

module front() {
    connectorsD=[connectorsWidth,sidesH-(baseH+padH+boardH)];
    connectorsPos=[connectorsX,sidesH-connectorsD.y];
    rotate([90,0,0]) {
        difference() {
            translate([-sidesThikness,0,0]) 
                linear_extrude(sidesThikness) square([boardD.x+2*sidesThikness, sidesH]);
            union() {
                translate([connectorsPos.x,sidesH-connectorsD.y+eps,-eps/2]) 
                    linear_extrude(sidesThikness+eps) square([connectorsD.x,connectorsD.y+eps]);
                translate([connectorsPos.x-1,sidesH-1,-eps/2]) 
                    linear_extrude(sidesThikness+eps) square([1+eps,1+eps]);
                translate([connectorsPos.x+connectorsD.x-eps,sidesH-1,-eps/2]) 
                    linear_extrude(sidesThikness+eps) square([1+eps,1+eps]);
            }
        }
    }
}

module back() {
    translate([0,boardD.y+sidesThikness,0]) rotate([90,0,0]) 
        difference() {
            translate([-sidesThikness,0,0]) 
                linear_extrude(sidesThikness) 
                    square([boardD.x+2*sidesThikness, sidesH]);
            translate([boardD.x-17.5-usbD.x,sidesH-usbD.y-eps/2,-eps/2]) 
                linear_extrude(sidesThikness+eps) square([usbD.x,usbD.y+eps]);    
        }
}

module side() {
    rotate([0,-90,0]) 
        translate([0,-sidesThikness,0]) 
            linear_extrude(sidesThikness) 
                square([sidesH, boardD.y+2*sidesThikness]);
}
