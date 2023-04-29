include <polyround.scad>

$fn=50;
eps = .1;

mirror([1,0,0]) {
    supportAndPin();
    translate([49,0,0]) supportAndPin();
    translate([17,50,0]) supportAndPin();
    translate([49,50,0]) supportAndPin();

    points = [[0,0], [5,0], [5,10], [49,10], [49,0], [54,0], [54,55], 
                [17,55], [17,50], [22,50], [22, 15], [0,15]];

    radiiPoints = addZcoord(points, 2.5);

    difference() {
        translate([-2.5,-2.5,0]) {
            linear_extrude(3, center=false) 
                polygon(polyRound(radiiPoints, 50));
        }

        translate([35.5,26,-eps/2]) {
            cylinder(h=3+eps, d=28);
            translate([-12.5,-12.5,0]) cylinder(h=3+eps, d=3);
            translate([-12.5, 12.5,0]) cylinder(h=3+eps, d=3);
            translate([ 12.5,-12.5,0]) cylinder(h=3+eps, d=3);
            translate([ 12.5, 12.5,0]) cylinder(h=3+eps, d=3);
        }
    }
}

module supportAndPin() {
    height = 21;
    cylinder(h=height, d=5);
    cylinder(h=height+7, d=2.5);
}