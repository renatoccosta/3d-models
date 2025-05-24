$fn=50;

eps = .1;
thikness=2;
baseD=[120,110];
padR=3.5;
padHeight=6;
screwHeight=5.2;
screwR=1.5;
boardThikness=9;
mainBoardD=[87,93,9];
mainBoardPadsD=[mainBoardD.x-padR*2,mainBoardD.y-padR*2];
speedBoardD=[24,70.1,9];
speedBoardPadsDistance=60;
speedBoardMargin=2;
capacitorD=[14.8,19,9.4];


linear_extrude(thikness) square(baseD);
translate([baseD.x-mainBoardPadsD.x-padR,baseD.y-mainBoardPadsD.y-padR,0]) mainBoardPads();
translate([padR+speedBoardMargin,baseD.y-speedBoardPadsDistance-padR-speedBoardMargin,0]) speedBoardPads();
%capacitor();
%connectors();

module pad() {
    difference() {
        linear_extrude(thikness+padHeight) circle(padR);
        translate([0,0,thikness+padHeight-screwHeight]) linear_extrude(screwHeight+eps) circle(screwR);
    }
}

module mainBoardPads() {
    pad();
    translate([mainBoardPadsD.x,0,0]) pad();
    translate([mainBoardPadsD.x,mainBoardPadsD.y,0]) pad();
    translate([0,mainBoardPadsD.y,0]) pad();
    %translate([-padR,-padR,thikness+padHeight]) color("LimeGreen", 0.5) cube(mainBoardD);
}

module speedBoardPads() {
    pad();
    translate([0,speedBoardPadsDistance,0]) pad();
    %translate([-padR-speedBoardMargin,-padR-speedBoardMargin,thikness+padHeight]) color("Khaki", 0.5) cube(speedBoardD);
}

module capacitor() {
    color("cyan",0.5) translate([0,0,thikness]) cube(capacitorD);
}

module connectors() {
    connectorsD=[43,39];
    translate([(baseD.x-connectorsD.x)/2,-connectorsD.y/2-thikness,thikness]) color("OrangeRed", 0.5) linear_extrude(7.35) square(connectorsD);
}