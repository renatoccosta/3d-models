include <polyround.scad>
include <variables.scad>
use <common-modules.scad>

baseP=[[0,0,5],
    [baseDepth+baseHeight,0,5],
    [baseDepth,baseHeight,5],
    [0,baseHeight,5]];
    
counterWeightD=[baseDepth-10, baseWidth-20, 11];

rotate([0,0,-90]) difference() {
    translate([0,baseWidth,0]) rotate([90,0,0]) polyRoundExtrude(baseP,baseWidth,5,5,50);
    translate([10,(baseWidth-counterWeightD.y)/2,-eps]) linear_extrude(counterWeightD.z+eps) square([counterWeightD.x, counterWeightD.y]);
    translate([baseDepth/2,baseWidth/2,baseHeight-standFixSize+eps]) standFixes();
    engrave();
}

module engrave() {
    translate([baseDepth+baseHeight,0,0]) rotate([0,45,0]) 
        translate([-(baseHeight*sqrt(2))/5*3,15,-2+eps]) rotate([0,0,90]) 
            linear_extrude(2+eps) {
                text(text="PY-6BK", size=14, font = "Liberation Mono:style=Bold", valign="center");
                translate([baseWidth-50,0,0]) scale([.25,.25,0]) import("logo.svg", center = true);
            }    
}

module standFixes() {
    y=180;
    translate([-standFixDistance/2,-y/2,0]) {
        standFix(standFixSize);
        translate([standFixDistance,0,0]) standFix(standFixSize);
        translate([0,y,0]) standFix(standFixSize);
        translate([standFixDistance,y,0]) standFix(standFixSize);
    }
}
