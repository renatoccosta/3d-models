$fn=100;
eps = .1;

baseH = 21;
baseR = 83.5;
screw_area = 17.5;
nipple = 5.5;
smart_switchD = [42,42];
wire_ductD = [(baseR*2)-(baseR/2)+2,10];
wire_duct_smart_switchD = [32,30];

difference() {
    cylinder(baseH, baseR, baseR + 1);
    translate([0,0,-eps/2]) linear_extrude(baseH + eps) {
        translate([0,50,0]) square(smart_switchD, true);
        circle(nipple-.5);
        translate([baseR/2,0,0]) circle(nipple+1);
    }
    
    translate([0,0,baseH*1/3]) {
        linear_extrude(baseH*2/3 + eps) {
            circle(screw_area);
            translate([baseR/2,0,0]) circle(screw_area);
        }
        
        linear_extrude(baseH*1/3) {
            translate([-baseR/4,0,0]) square(wire_ductD, true);
            translate([0, wire_duct_smart_switchD.y/2,0]) square(wire_duct_smart_switchD, true);
        }        
    }
    
    translate([0,0,baseH*1/13]) {
        linear_extrude(baseH*12/13+eps) {
            translate([baseR/2,baseR/2,0]) circle(screw_area);
            translate([baseR/2,-baseR/2,0]) circle(screw_area);
            translate([-baseR/2,baseR/2,0]) circle(screw_area);
            translate([-baseR/2,-baseR/2,0]) circle(screw_area);
        }
    }
}