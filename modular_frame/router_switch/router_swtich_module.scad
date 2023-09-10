include <../modules/base_variables.scad>
use <../modules/faceplate_2u.scad>
use <../opi_r1/opi_r1_lts_eth.scad>
use <switch_8p.scad>

margins=[0,11];
switchPadding=[22,4];
routerPadding=[28,32];

difference() {
    translate([-margins.x, -margins.y, -thikness]) 
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