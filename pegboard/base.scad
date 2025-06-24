$fn=50;
eps=.1;


pinHolder(4,2);

module pinHolder(x,y) {
    pitch=26;
    
    translate([-pitch*(x-1)/2,-pitch*(y-1)/2,-3.6])
    for(i=[0:x-1]) {
        for(j=[0:y-1]) {            
            translate([pitch*i,pitch*j,0]) {
                linear_extrude(1.6) circle(d=8.8);
                translate([0,0,1.6]) linear_extrude(2) circle(d=4.5);    
            }
        }
    }
}

