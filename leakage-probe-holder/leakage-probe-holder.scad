$fn=50;
eps=.1;
thikness=1.5;
vaseWallThikness=12;
waterLevelDepth=90;
probeHeight=20;
cableD=3.5;
holderWidth=15;
pinD=3.3;
pinDepth=5;

holderP=[
    [0,0],
    [30,0],
    [30,thikness],
    [3,thikness],
    [3,thikness+vaseWallThikness],
    [3+waterLevelDepth,thikness+vaseWallThikness],
    [3+waterLevelDepth,thikness+vaseWallThikness+10],
    [3+waterLevelDepth+probeHeight-thikness,thikness+vaseWallThikness+10],
    [3+waterLevelDepth+probeHeight-thikness,thikness+vaseWallThikness+10+thikness],
    [3+waterLevelDepth-thikness,thikness+vaseWallThikness+10+thikness],
    [3+waterLevelDepth-thikness,thikness+vaseWallThikness+thikness],
    [0,thikness+vaseWallThikness+thikness]
];

difference() {
    linear_extrude(holderWidth) polygon(holderP);
    translate([-eps/2,-eps/2,(holderWidth-cableD)/2]) 
        linear_extrude(cableD) square([cableD+eps, eps+2*thikness+vaseWallThikness]);
}

translate([3+waterLevelDepth+probeHeight-thikness-probeHeight/2,2*thikness+vaseWallThikness+10,holderWidth/2]) rotate([-90,0,0]) pin();


module pin() {
    linear_extrude(pinDepth) circle(pinD/2);
    translate([0,0,pinDepth]) sphere(pinD/2);
}