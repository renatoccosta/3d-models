faceplate(1);

module faceplate(slots=1) {
    $fn=50;
    eps = 1;
    _1u = 44;
    face = [slots * _1u, _1u * 2, 2];
    holeOffset = 5.5;

    difference() {
        linear_extrude(face.z) square([face.x, face.y]);    
        
        //fixing screw holes
        for (i = [1:2:slots*2]) {
            translate([_1u/2 * i, 0, -eps / 2]) {
                translate([0, holeOffset, 0]) cylinder(h=face.z+eps, d1=7, d2=4);
                translate([0, face.y - holeOffset, 0]) cylinder(h=face.z+eps, d1=7, d2=4);
            }  
        }
    }
}

module screwHoles() {
}
