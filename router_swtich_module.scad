use <faceplate_2u.scad>
use <opi_r1_lts_eth.scad>
use <switch_8p.scad>

faceZ = 2;
margins=[0,11];
switchPadding=[22,4];
routerPadding=[28,32];

difference() {
    translate([-margins.x, -margins.y, -faceZ]) 
        faceplate(4);
    pad(routerPadding) 
        routerMask();    
    pad(switchPadding) 
        switchMask();
}

pad(routerPadding) routerSupport();
pad(switchPadding) switchSupport();

module pad(padding) {
    translate([padding.x, padding.y, 0]) children();
}