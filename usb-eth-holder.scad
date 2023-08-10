eps=1;

eth_z=63;

linear_extrude(eth_z) {
    square([2,6]);
    translate([28,0,0]) square([2,6]);
    square([30,2]);
}

translate([0,0,eth_z]) linear_extrude(2) square([30,6]);

translate([0,18,0]) linear_extrude(6) square([30,2]);

linear_extrude(6) {
    square([2,18]);
    translate([28,0,0]) square([2,18]);
}

difference() {
    translate([-12.5,-6,-2]) linear_extrude(2) square([55,45]);
    translate([7,4.5,-2-eps/2]) linear_extrude(2+eps) square([16,11]);
    translate([16+7,20,-2-eps]) linear_extrude(1+eps) 
        mirror([1,0,0])
            text(text="WAN2",size=5, font="Lucida Console:style=Regular");
}
