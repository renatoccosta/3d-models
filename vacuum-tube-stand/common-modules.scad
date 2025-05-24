include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <variables.scad>

standFixPair();

module pairDoubleClip(standFixSize=10, standFixDistance=45) {
    translate([-standFixDistance/2,0,0]) {
        doubleClip(standFixSize);
        translate([standFixDistance,0,0]) doubleClip(standFixSize);    
    }
}

module doubleClip(standFixSize=10) {
    translate([-standFixSize/2,0,0]) clip(standFixSize);
    mirror([1,0,0]) translate([-standFixSize/2,0,0]) clip(standFixSize);
}

module clip(d=10) {        
    d10=d/10;
    d4=d/4;
    d2=d/2;
    clipStrengh=1.5;
    
    linear_extrude(d)
        polygon([[0,0],[-d10,d4],[0,d2],[0,d],[clipStrengh,d],[clipStrengh,0]]);
}

module standFix(d=10) {
    d10=d/10;
    d4=d/4;
    d2=d/2;
    
    translate([-d/2,d/2,0]) rotate([90,0,0]) linear_extrude(d+eps) {
        polygon([[0,0],[d,0],[d+d10,d4],[d,d2],[d,d],[0,d],[0,d2],[-d10,d4]]);
    }
}

module standFixPair(standFixSize=10,standFixDistance=45) {
    translate([-standFixDistance/2,0,0]) {
        standFix(standFixSize);
        translate([standFixDistance,0,0]) standFix(standFixSize);
    }
}

module sideFrame2d(r=3) {
    path=[[0,0],[0,sidesThikness],[sidesThikness,sidesThikness],[sidesThikness,0]];
    polygon(round_corners(path, radius=r));
}

module bottomFrame2d(r=3) {
    path=[[0,0],[0,sidesThikness],[sidesThikness,sidesThikness],[sidesThikness,0]];
    polygon(round_corners(path, radius=[0,r,r,0]));
}
