include <variables.scad>

coverH = 1.5;
sideH = coverH + 3.8;

//base
difference() {
    linear_extrude(coverH) square(boardD);
    connectors();
    translate([boardD.x/4,boardD.y/5*2,-eps/2]) scale([.4,.4,1]) rotate([0,0,0]) mirror([1,0,0]) 
        linear_extrude(coverH+eps) import("ha-logo.svg", center = true);
}

difference() {
    sides();
    snaps();
}


module sides() {    
    usbD=[usbD.x,usbD.y+1];
    //front
    translate([-sidesThikness,0,0]) rotate([90,0,0]) linear_extrude(sidesThikness) square([boardD.x+2*sidesThikness, sideH]);
    //back
    translate([-sidesThikness,boardD.y+sidesThikness]) rotate([90,0,0]) {
        difference() {
            linear_extrude(sidesThikness) square([boardD.x+2*sidesThikness, sideH]);
            translate([17.5+sidesThikness,sideH-usbD.y-eps/2,-eps/2]) linear_extrude(sidesThikness+eps) square([usbD.x,usbD.y+eps]);
        }
    }
    //left
    translate([0,-sidesThikness,0]) rotate([0,-90,0]) linear_extrude(sidesThikness) square([sideH,boardD.y+2*sidesThikness]);
    //right
    translate([boardD.x+sidesThikness,-sidesThikness,0]) rotate([0,-90,0]) linear_extrude(sidesThikness) square([sideH,boardD.y+2*sidesThikness]);
}

module snaps() {
    snap=1.1;
    snapH=snap-.1;
    translate([-snap,-snap,sideH-snapH]) linear_extrude(snapH+eps) square([boardD.x+sidesThikness, snap+eps]);
    translate([-snap,boardD.y-eps,sideH-snapH]) linear_extrude(snapH+eps) square([boardD.x+sidesThikness, snap+eps]);
    translate([-snap,-snap,sideH-snapH]) linear_extrude(snapH+eps) square([snap+eps,boardD.y+sidesThikness]);
    translate([boardD.x-eps,-snap,sideH-snapH]) linear_extrude(snapH+eps) square([snap+eps,boardD.y+sidesThikness]);
}

module connectors() {
    connectorsD=[connectorsWidth,6.5];    
    translate([boardD.x-connectorsX-connectorsD.x,0,-eps/2]) linear_extrude(coverH+eps) square(connectorsD);
}

module pins() {
    
}