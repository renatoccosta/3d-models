include <BOSL2/std.scad>
include <BOSL2/rounding.scad>

$fn=50;

eps = .1;
baseThikness=2;
baseD=[120,110];
padR=3.5;
padHeight=6;
screwHeight=5.2;
screwR=1.5;
boardThikness=1.7;
mainBoardD=[87,93,16+boardThikness];
mainBoardPadsD=[mainBoardD.x-padR*2,mainBoardD.y-padR*2];
speedBoardD=[24,70.1,18+boardThikness];
speedBoardPadsDistance=60;
speedBoardMargin=2;
capacitorD=[30,38,18.8];
coverFixInsetHR=[1.3,3.6/2];
coverFixHoleR=1.25;
coverFixMargin=(coverFixInsetHR.y*2)-(coverFixInsetHR.y*(2-sqrt(2)))/2;
fullBaseD=baseD+[(coverFixMargin+1)*2,(coverFixMargin+1)*2];
coverH=baseThikness+padHeight+max(mainBoardD.z,speedBoardD.z);

difference() {
    linear_extrude(baseThikness) square(fullBaseD);
    translate([coverFixInsetHR.y+1,coverFixInsetHR.y+1,-eps]) coverFixInset();
    translate([fullBaseD.x-coverFixInsetHR.y-1,fullBaseD.y-coverFixInsetHR.y-1,-eps]) coverFixInset();
    translate([fullBaseD.x-coverFixInsetHR.y-1,coverFixInsetHR.y+1,-eps]) coverFixInset();
    translate([coverFixInsetHR.y+1,fullBaseD.y-coverFixInsetHR.y-1,-eps]) coverFixInset();
}

translate([coverFixMargin+1,coverFixMargin+1,0]) {
    translate([baseD.x-mainBoardPadsD.x-padR,baseD.y-mainBoardPadsD.y-padR,0]) mainBoardPads();
    translate([padR+speedBoardMargin,baseD.y-speedBoardPadsDistance-padR-speedBoardMargin,0]) speedBoardPads();
    %capacitor();
    %connectors();
}

color("Azure") translate([0,0,baseThikness]) cover();
    

module pad() {
    difference() {
        linear_extrude(baseThikness+padHeight) circle(padR);
        translate([0,0,baseThikness+padHeight-screwHeight]) linear_extrude(screwHeight+eps) circle(screwR);
    }
}

module mainBoardPads() {
    pad();
    translate([mainBoardPadsD.x,0,0]) pad();
    translate([mainBoardPadsD.x,mainBoardPadsD.y,0]) pad();
    translate([0,mainBoardPadsD.y,0]) pad();
    %translate([-padR,-padR,baseThikness+padHeight]) color("LimeGreen", 0.5) cube(mainBoardD);
}

module speedBoardPads() {
    pad();
    translate([0,speedBoardPadsDistance,0]) pad();
    %translate([-padR-speedBoardMargin,-padR-speedBoardMargin,baseThikness+padHeight]) color("Khaki", 0.5) cube(speedBoardD);
}

module capacitor() {
    color("cyan",0.5) translate([0,0,baseThikness]) cube(capacitorD);
}

module connectors() {
    connectorsD=[43,39,14.6];
    translate([(baseD.x-connectorsD.x)/2,-connectorsD.y/2-baseThikness,baseThikness]) color("OrangeRed", 0.5) cube(connectorsD);
}

module coverFixInset() {
    linear_extrude(coverFixInsetHR.x+eps) circle(coverFixInsetHR.y);
    linear_extrude(baseThikness+2*eps) circle(coverFixHoleR);
}

module cover() {
    difference() {
        linear_extrude(coverH) square(fullBaseD);
        translate([baseThikness,baseThikness,-baseThikness]) linear_extrude(coverH-baseThikness+eps) square(fullBaseD-[baseThikness*2,baseThikness*2]);
    }
}