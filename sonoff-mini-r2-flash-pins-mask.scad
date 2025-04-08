$fn=100;
eps = .1;

thikness = 2;
boardD = [7,9];
pinhole = 1.25;
pinholeP = [4.5,6.5,0];


difference() {
    linear_extrude(thikness) square(boardD);
    translate([0,0,-eps/thikness]) {
        translate(pinholeP) linear_extrude(thikness+eps) circle(d=pinhole);
        translate([pinholeP.x, pinholeP.y-1.5, 0]) linear_extrude(thikness+eps) circle(d=pinhole);
        translate([pinholeP.x-1.5, pinholeP.y-2.25, 0]) linear_extrude(thikness+eps) circle(d=pinhole);
        translate([pinholeP.x-2.25, pinholeP.y-3.5, 0]) linear_extrude(thikness+eps) circle(d=pinhole);
    }
}