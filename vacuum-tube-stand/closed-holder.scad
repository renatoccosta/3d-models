include <polyround.scad>
include <variables.scad>
use <common-modules.scad>

objR=65/2;
margin=10;
frameD=[objR*2+margin*2,objR*2+margin];
champferR=3;
            
difference() {
    holder();
    outsideChampfer(champferR);
    insideChampfer(champferR);
}
translate([0,-standFixSize,-standFixSize/2]) doubleClip(standFixSize);


module holder() {
    rate=.75;
    holdRate=.5;
        
    difference() {
        translate([0,0,-standFixSize/2]) difference() {
            linear_extrude(standFixSize) frame();
            translate([0,frameD.y,-eps/2]) linear_extrude(standFixSize+eps) #circle(objR);
        }  
       lowerDetail();
    }
}

module frame() {
    translate([-frameD.x/2,0]) square(frameD);
    translate([0, frameD.y]) circle(frameD.x/2);
}

module lowerDetail() {
    detailD=[frameD.x-margin*2+champferR*2,frameD.y+champferR*2];
     
    difference() {
        translate([0,margin-champferR,0]) {
            difference() {
                translate([-detailD.x/2,0,-(standFixSize+eps)/2]) 
                    linear_extrude(standFixSize+eps) 
                        square(detailD);
                translate([-(detailD.x+eps)/2,champferR,0]) 
                    rotate([0,90,0]) rotate([0,0,-90]) 
                        linear_extrude(detailD.x+eps) newConcaveChampfer(champferR);
                for(x=[0,1,1])
                    mirror([x,0,0]) translate([detailD.x/2-champferR,-eps/2,0]) rotate([-90,0,0])
                        linear_extrude(detailD.y+eps) newConcaveChampfer(champferR);
                
            }
        }
        translate([0,frameD.y,0]) {
            translate([0,0,-(standFixSize+eps*2)/2]) 
                #linear_extrude(standFixSize+eps*2) circle(frameD.x/2-champferR+.01);
            #rotate_extrude() 
                translate([frameD.x/2,0]) 
                    mirror([1,0]) 
                        newConcaveChampfer(champferR);
        }
    }    
}

module outsideChampfer(r=3) {
    for(x=[0:1:1])
        for(y=[0:1:1])
            mirror([x,0,0]) mirror([0,0,y]) champferSide(r);
}

module champferSide(r) {
    translate([-r+frameD.x/2,frameD.y+eps/2,-r+standFixSize/2]) 
        rotate([90,0,0]) 
            linear_extrude(frameD.y+eps)
                champfer2d(r);
    translate([0,frameD.y,-r+standFixSize/2])
        champferArc(r);
}

module champferArc(r=3) {
    rotate_extrude(angle=90, $fn=50) 
        translate([-r+frameD.x/2,0])
            champfer2d(r);
}

module insideChampfer(r=3) {
    translate([0,frameD.y,0]) {
        translate([0,0,-standFixSize/2])
            rotate_extrude() 
                translate([r+objR,r]) mirror([1,1]) champfer2d(r);
        mirror([0,0,1])
            translate([0,0,-standFixSize/2])
                rotate_extrude() 
                    translate([r+objR,r]) mirror([1,1]) champfer2d(r);
    }
}

module champfer2d(r=3) {
    difference() {
        square([r+eps,r+eps]);
        circle(r);
    }
}

module concaveChampfer(r=3) {
    translate([r,r]) mirror([1,1])
    difference() {
        square([r+eps,r+eps]);
        circle(r);
    }
}

module concaveChampferLinear(r=3,h=10) {
    linear_extrude(h)
        translate([r,r]) mirror([1,1]) difference() {
            square([r,r]);
            circle(r);
        }
}

module concaveChampferAngled(r=3,a=90) {
    rotate_extrude(angle=a) 
        translate([r,r]) mirror([1,1]) difference() {
            square([r,r]);
            circle(r);
        }
}

module newConcaveChampfer(r=3) {
    translate([0,-(standFixSize-2*r)/2]) difference() {
        union() {
            square([r,standFixSize-2*r]);
            translate([r,standFixSize-2*r]) circle(r);
            translate([r,0]) circle(r);
        }
        translate([r,-r]) square([r,standFixSize]);
    }
}
