$fn=50;

eps = .1;

baseD = [41.65, 14.55];
baseH = 2;
innerHolderD = [25.5, 11.3];
innerHolderH = 3.8;
innerHolderChampferD = [7.5,0.9];
sideHolderD = [3.25, 6.55-3.25];


linear_extrude(baseH) square(baseD);

translate([(baseD.x-innerHolderD.x)/2,1.55,0]) {
    difference() {
        linear_extrude(baseH+innerHolderH) square(innerHolderD);
        translate([(innerHolderD.x-innerHolderChampferD.x)/2, innerHolderD.y-innerHolderChampferD.y+eps, baseH]) 
            linear_extrude(innerHolderH+eps)
                square(innerHolderChampferD);
    }
}

translate([0,baseD.y/2,0]) {
    translate([2.22+sideHolderD.x/2,0,0]) sideHolder(sideHolderD, innerHolderH+3);
    translate([baseD.x - 2.22 - sideHolderD.x/2,0,0]) sideHolder(sideHolderD, innerHolderH+3);
}

module sideHolder(sideHolderD, sideHolderH) {    
    translate([-sideHolderD.x/2,-sideHolderD.y/2,0]) linear_extrude(baseH+sideHolderH) {
       square(sideHolderD);
        translate([sideHolderD.x/2,0,0]) {
            circle(d=sideHolderD.x);
            translate([0,sideHolderD.y,0]) circle(d=sideHolderD.x);
        }
    }
}