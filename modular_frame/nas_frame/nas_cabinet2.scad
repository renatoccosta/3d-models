include <polyround.scad>
include <../modules/base_variables.scad>

canvasD = [72,66];

sideUpDownD = [canvasD.x+2*thikness,82];

translate([thikness,0]) rotate([0,-90,0]) sidesLeftRight();
translate([canvasD.x+2*thikness,0]) rotate([0,-90,0]) sidesLeftRight();
translate([0,thikness]) rotate([90,0,0]) side(sideUpDownD);
translate([0,canvasD.y+2*thikness]) rotate([90,0,0]) side(sideUpDownD);

module side(sideD = [82,canvasD.y]) {
    linear_extrude(thikness) 
    shell2d(-5) {
        square(sideD);
        gridSide = sqrt(sideD.x^2 + sideD.y^2);
        gridDiag = gridSide * sqrt(2);
        translate([-(gridDiag/2-sideD.x/2),sideD.y/2,0]) 
            rotate([0,0,-45]) 
                grid(size=[gridSide,gridSide], slots=7);
    }
}

module grid(size = [100,100], slots = 5, ratio = .35) {    
    gutterSize = [size.x/slots*ratio, size.y/slots*ratio];
    
    for (i=[0:1:slots]) {
        for (j=[0:1:slots]) {
                translate([i*size.x/(slots+ratio), 0]) square([gutterSize.x, size.y]);
                translate([0, j*size.x/(slots+ratio)]) square([size.x, gutterSize.y]);
        }
    }
}

module sidesLeftRight() {
    sideLeftRightD = [82,canvasD.y+2*thikness];
    supportX=10;
    screwHole=1.7;
    difference() {
        union() {
            side(sideLeftRightD);
            linear_extrude(thikness) 
                square([supportX,sideLeftRightD.y]);
        }
        translate([supportX/2,supportX/2,-eps/2]) 
            linear_extrude(thikness+eps) 
                circle(screwHole);
        translate([supportX/2,sideLeftRightD.y-supportX/2,-eps/2]) 
            linear_extrude(thikness+eps) 
                circle(screwHole);
    }
}